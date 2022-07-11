/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package boundary;

import control.OrarioLavoroStore;
import entity.OrarioLavoro;
import java.util.List;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
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
import security.JWTManager;

/**
 *
 * @author andrelima
 */
@Path("/orari")
@Tag(name = "Gestione OrariLavoro", description = "Permette di gestire i OrariLavori per Ristoranti")
@DenyAll
public class OrariLavoroResources {
    
    @Inject
    private OrarioLavoroStore storeorari;

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
    @Operation(description = "Restituisce l'elenco di Orari Lavorativi")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<OrarioLavoro> all(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {

        return storeorari.all();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo Orario di Lavoro")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo Orario creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione fallita")
    })
    @RolesAllowed({"Admin","User"})
    public Response create(@Valid OrarioLavoro entity) {
        
        OrarioLavoro saved = storeorari.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }
    
}
