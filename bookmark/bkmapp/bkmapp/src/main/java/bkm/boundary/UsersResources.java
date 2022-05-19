/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bkm.boundary;

import bkm.security.JWTManager;
import bkm.control.UserStore;
import bkm.control.BookStore;
import bkm.entity.Book;
import bkm.entity.User;
import java.time.LocalDate;
import java.util.List;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.stream.JsonCollectors;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.container.ResourceContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.core.UriInfo;
import org.eclipse.microprofile.jwt.Claim;
import org.eclipse.microprofile.jwt.JsonWebToken;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponses;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

/**
 *
 * @author tss
 */
@Path("/users")
@Tag(name = "Gestione Users", description = "Permette di gestire gli utenti di blogapp")
@DenyAll
public class UsersResources {
    
    @Inject
    private UserStore storeuser;
    
    @Inject
    private BookStore storebook;

    @Context
    ResourceContext rc;
    
    @Context
    UriInfo uriInfo;
    
    @Inject
    private JWTManager jwtManager;
    
    @Inject
    private JsonWebToken token;
    
    @Claim(value = "sub")
    private String sub;
        
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce l'elenco di tutti gli utenti")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo")
    })
    @RolesAllowed("users")
    public List<User> all(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {
        System.out.println(token);
        return storeuser.allPaginated(page,size);
    }
    
    @GET
    @Path("allslice")
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce l'elenco con informazioni ridotte di tutti gli utenti")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo")
    })
    @PermitAll
    public JsonArray allSlice() {
        /*System.out.println(token);*/
        return storeuser.all().stream().map(User::toJsonSliceName).collect(JsonCollectors.toJsonArray());
    }
    
    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce la risorsa utente identificata dall'ID")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Utente ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Utente non trovato")
    })
    @RolesAllowed("users")
    public User find(@PathParam("id") Long id) {
        return storeuser.find(id).orElseThrow(() -> new NotFoundException("user non trovato. id=" + id));
    }
    
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo utente")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo utente creato con successo")
    })
    @PermitAll
    public Response create(@Valid User entity) {
        User saved = storeuser.save(entity);
        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }
    
    
    @POST
    @Path("login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @PermitAll
    public JsonObject login (@Valid Credential credential){
        
        User u = storeuser.login(credential).orElseThrow(() -> new NotAuthorizedException("User non Authorized",  
                                                                       Response.status(Response.Status.UNAUTHORIZED).build()));
               
        String jwt = jwtManager.generate(u);
        
        return  Json.createObjectBuilder()
                .add("user", u.getEmail())
                .add("token",jwt)
                .build();
    }
    
    
    
    @DELETE
    @Path("{id}")
    @Operation(description = "Elimina una risorsa Utente tramite l'ID")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Utente eliminato con successo"),
        @APIResponse(responseCode = "404", description = "Utente non trovato")

    })
    public void delete(@PathParam("id") Long id) {
        User found = storeuser.find(id).orElseThrow(() -> new NotFoundException("user non trovato. id=" + id));
        storeuser.delete(found.getId());
    }
    
    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Aggiorna i dati dell'utente")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Nuovo utente creato con successo")
    })
    public User update(@PathParam("id") Long id, @Valid User entity) {
        User found = storeuser.find(id).orElseThrow(() -> new NotFoundException("user non trovato. id=" + id));
        entity.setId(id);
        return storeuser.update(entity);
    }
    
/*------------------------------ bookmarks ---------*/
    
    @POST
    @Path("{id}/bkms")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)   
    @Operation(description = "Permette la registrazione di un nuovo BookMark")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo BookMark creato con successo")
    })
    @RolesAllowed("users")
    public Response create(@PathParam("id") Long id, @Valid Book entity) {
        //System.out.println("id: " + token.getName());
        System.out.println(entity.toString());
        User usr = storeuser.find(id).orElseThrow(() -> new NotFoundException("user non trovato. id=" + token.getName()));
        entity.setUsr(usr);
        entity.setCreazione(LocalDate.now());
        Book saved = storebook.save(entity);
        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }
    
    
}