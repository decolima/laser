/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package boundary;

import boundary.mapping.ConsegnaDto;
import control.ConsegnaStore;
import control.UserStore;
import entity.Consegna;
import entity.User;
import entity.constant.StatusConsegna;
import java.util.List;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
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
import security.JWTManager;

/**
 *
 * @author andrelima
 */
@Path("/consegna")
@Tag(name = "Gestione Consegna", description = "Permette di gestire le consegne")
@DenyAll
public class ConsegnaResources {
    
    @Inject
    private UserStore storeuser;
    
     @Inject
    private ConsegnaStore storeconsegna;
    
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
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette l'aggiornamento di una consegna")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Consegna aggirnata con successo"),
        @APIResponse(responseCode = "404", description = "Aggiornamento fallito")
    })
    //@RolesAllowed({"Admin","User"})
    @PermitAll
    public List<Consegna> listall() {
                
        return storeconsegna.all();
        
        
    }
    
    
    @GET
    @Path("do")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette l'aggiornamento di una consegna")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Consegna aggirnata con successo"),
        @APIResponse(responseCode = "404", description = "Aggiornamento fallito")
    })
    @RolesAllowed({"Admin","User"})
    public List<Consegna> listDoConsegna() {
                
        return storeconsegna.doConsegna();
        
        
    }
    
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette l'aggiornamento di una consegna")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Consegna aggirnata con successo"),
        @APIResponse(responseCode = "404", description = "Aggiornamento fallito")
    })
    //@RolesAllowed({"Admin","User"})
    @PermitAll
    public Consegna crea(@Valid Consegna entity) {
                
        return storeconsegna.save(entity);
        
        
    }
    
    
    @POST
    @Path("aggiorna")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette l'aggiornamento di una consegna")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Consegna aggirnata con successo"),
        @APIResponse(responseCode = "404", description = "Aggiornamento fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response aggiornaConsegna(@Valid ConsegnaDto cs) {
        
        System.out.println(token);
        
        System.out.println(cs.idconsegna.toString());
        
        if(!storeuser.findUserbyLogin(token.getName()).isPresent()){
            
            return Response.status(Response.Status.PRECONDITION_FAILED).build();
        }
        
        User usr = storeuser.findUserbyLogin(token.getName()).orElseThrow(() -> new NotFoundException("User non trovato. id=" + token.getName()));
       
        Consegna cng = storeconsegna.find(cs.idconsegna).orElseThrow(() -> new NotFoundException("Consegna non trovata. id=" + cs.idconsegna));
        
        storeconsegna.aggiornaConsegna(cng, usr, cs.st);
        
        return Response.status(Response.Status.ACCEPTED)
                .build();
    }
    
}
