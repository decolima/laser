/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bkm.boundary;

import bkm.control.BookStore;
import bkm.entity.User;
import bkm.entity.UserRoles;
import bkm.control.UserStore;
import bkm.entity.Book;
import bkm.security.JWTManager;
import java.time.LocalDate;
import java.util.List;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.PATCH;
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
@Path("/books")
@Tag(name = "Gestione di BookMarks", description = "Permette di gestire BookMarks")
@DenyAll
public class BooksResources {
    
    @Inject
    private BookStore storebook;

    @Inject
    private UserStore storeuser;
    
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
    @Operation(description = "Restituisce tutti BookMark di uno uttenti")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non ritornato trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<JsonObject> all(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {
        System.out.println(token);
        User usr = storeuser.findUserbyLogin(token.getName()).orElseThrow(() -> new NotFoundException("user non trovato. id=" + token.getName()));
        System.out.println(usr.toString());
        return storebook.findAllByUserJson(usr.getId(), page,size);
    }
        
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)   
    @Operation(description = "Permette la registrazione di un nuovo BookMark")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo BookMark creato con successo"),
        @APIResponse(responseCode = "404", description = "Non è stato possibile creare nuovo BookMark")
    })
    @RolesAllowed({"Admin","User"})
    public Response create(@Valid Book entity) {
        System.out.println("id: " + token.getName());
        System.out.println(entity.toString());
        User usr = storeuser.findUserbyLogin(token.getName()).orElseThrow(() -> new NotFoundException("user non trovato. id=" + token.getName()));
        entity.setUsr(usr);
        entity.setCreazione(LocalDate.now());
        Book saved = storebook.save(entity);
        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }
    
    
    /*-------Tags a un BookMark----------*/
    
    @PATCH
    //@Path("{id}")
    @Operation(description = "Permette aggiungere una lista di Tag a un BookMark")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "BookMark aggiornato con successo"),
        @APIResponse(responseCode = "404", description = "Non è stato possibile aggiornare il BookMark")
    })
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)   
    @RolesAllowed({"Admin","User"})
    public Response addTag(JsonObject jbook){
        
        System.out.println(jbook);
        
        String tg = jbook.getString("Tags");
        String[] tgs = tg.split("#");
        
        Book found = storebook.find(Long.parseLong(jbook.getString("idBook"))).orElseThrow(() -> new NotFoundException());
        
        storebook.addTag(found,tgs);
        
        return Response.status(Response.Status.CREATED)
                .build();
        
    }
    
    @DELETE
    @Operation(description = "Permette cancellare un BookMark")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "BookMark cancellato con successo"),
        @APIResponse(responseCode = "404", description = "Non è stato possibile cancellare il BookMark")
    })
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)   
    @RolesAllowed({"Admin","User"})
    public Response cancellaBook(JsonObject jbook){
        
        System.out.println(jbook);
        
        Book found = storebook.find(Long.parseLong(jbook.getString("idBook"))).orElseThrow(() -> new NotFoundException());
        
        storebook.delete(found.getId());
        
        return Response.status(Response.Status.OK)
                .build();
        
    }
       
}
