/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package boundary;

import control.CorriereStore;
import control.UserStore;
import entity.Consegna;
import entity.Corriere;
import java.util.List;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.container.ResourceContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
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
@Path("/corriere")
@Tag(name = "Gestione Corriere", description = "Permette di gestire le persone Corriere")
@DenyAll
public class CorriereResources {

    @Inject
    private UserStore storeuser;
    
    @Inject
    private CorriereStore storecorriere;
    
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
    @Operation(description = "Permette listare tutti corriere")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Carricamento fatto"),
        @APIResponse(responseCode = "404", description = "Carricamento fallito")
    })
    //@RolesAllowed({"Admin","User"})
    @PermitAll
    public List<Corriere> listall() {
                
        return storecorriere.all();
        
        
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette inserire un corriere + macchine")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Corriere creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione fallita")
    })
    //@RolesAllowed({"Admin","User"})
    @PermitAll
    public void crea(@Valid Corriere entity) {
                
         storecorriere.save(entity);
        
        
    }

    
}
