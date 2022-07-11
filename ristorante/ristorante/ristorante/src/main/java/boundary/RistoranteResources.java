/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package boundary;

import boundary.mapping.OrariRistorante;
import boundary.mapping.RistoranteOdt;
import entity.OrarioLavoro;
import control.OrarioLavoroStore;
import control.PrenotazioneStore;
import entity.Prenotazione;
import entity.Ristorante;
import control.RistoranteStore;
import control.TavoloStore;
import entity.Tavolo;
import control.MenuStore;
import entity.Menu;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.validation.Valid;
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
import security.JWTManager;

/**
 *
 * @author andrelima
 */
@Path("/ristorante")
@Tag(name = "Gestione Ristorante", description = "Permette di gestire i ristotrnte")
@DenyAll
public class RistoranteResources {

    @Inject
    private RistoranteStore storeristorante;

    @Inject
    private TavoloStore storetavolo;

    @Inject
    private PrenotazioneStore storeprenotazione;
    
    @Inject
    private OrarioLavoroStore storeorari;
    
    @Inject
    private MenuStore storemenu;

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
    @Operation(description = "Restituisce l'elenco di tutti i ristorante")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<Ristorante> all(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {

        List<Ristorante> list = storeristorante.all();
        
        return list;
    }
    
    @GET
    @Path("singolo")
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce l'elenco di ristorante")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<RistoranteOdt> oneOdt(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {

        return storeristorante.gettutti();
    }
    

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response create(@Valid Ristorante entity) {

        if (storeristorante.findbyNome(entity.getNome()).isPresent()) {

            return Response.status(Response.Status.PRECONDITION_FAILED).build();
        }

        Ristorante saved = storeristorante.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }

    @PATCH
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette aggingere un Orario di Laboro al ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Orario aggiornato con successo"),
        @APIResponse(responseCode = "404", description = "Aggiornamento fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response addOrarioRistorante(@Valid OrariRistorante entity) {

        Optional<Ristorante> ris = storeristorante.find(entity.idristorante);
        Optional<OrarioLavoro> orari = storeorari.find(entity.idorario);

        
        if (!ris.isPresent()) {
            return Response.status(Response.Status.PRECONDITION_FAILED).build();
        }
    
        if (!orari.isPresent()) {
            return Response.status(Response.Status.PRECONDITION_FAILED).build();
        }        
        
        storeristorante.addOrari(ris.get(), orari.get());
        
        return Response.status(Response.Status.CREATED)
                .build();
    }
    
    
    //-------Gestione Tavoli--------
    @GET
    @Path("tavolo")
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce l'elenco di tutti i ristorante")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<Tavolo> alltavoli(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {

        return storetavolo.all();
    }
    
    

    @POST
    @Path("tavolo")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response createtavoli(@Valid Tavolo entity) {

        Tavolo saved = storetavolo.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }

    @PUT
    @Path("tavolo")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response updatetavoli(@Valid Tavolo entity) {

        Tavolo found = storetavolo.find(entity.getId()).orElseThrow(() -> new NotFoundException("Tavolo non trovato. id=" + entity.getId().toString()));

        found = storetavolo.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(found)
                .build();
    }

    
    //-------Gestione Prenotazione--------
    @GET
    @Path("prenotazione")
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce l'elenco di tutti i ristorante")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<Prenotazione> allprenotazione(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {

        return storeprenotazione.all();
    }

    @POST
    @Path("prenotazione")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response createprenotazione(@Valid Prenotazione entity) {

        entity.setDatap(LocalDateTime.now());
        
        Prenotazione saved = storeprenotazione.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }

    @PUT
    @Path("prenotazione")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response updateprenotazione(@Valid Prenotazione entity) {

        Prenotazione found = storeprenotazione.find(entity.getId()).orElseThrow(() -> new NotFoundException("Prenotazione non trovato. id=" + entity.getId().toString()));

        found = storeprenotazione.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(found)
                .build();
    }

    @DELETE
    @Path("prenotazione/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response deleteprenotazione(@PathParam("id") Long id) {

        Prenotazione found = storeprenotazione.find(id).orElseThrow(() -> new NotFoundException("Prenotazione non trovato. id=" + id.toString()));

        storeprenotazione.delete(id);

        return Response.status(Response.Status.CREATED)
                .entity(found)
                .build();
    }

    
    //--------Gestione Takeaway
    
    @GET
    @Path("takeaway")
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Restituisce l'elenco di tutti i ristorante")
    @APIResponses({
        @APIResponse(responseCode = "200", description = "Elenco ritornato con successo"),
        @APIResponse(responseCode = "404", description = "Elenco non trovato")
    })
    @RolesAllowed({"Admin","User"})
    public List<Menu> alltakeaway(@DefaultValue("1") @QueryParam("page") int page, @DefaultValue("10") @QueryParam("size") int size) {

        return storemenu.all();
    }

    @POST
    @Path("takeaway")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @PermitAll
    public Response createtakeaway(@Valid Prenotazione entity) {

        entity.setDatap(LocalDateTime.now());
        
        Prenotazione saved = storeprenotazione.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(saved)
                .build();
    }

    @PUT
    @Path("takeaway")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response updatetakeaway(@Valid Prenotazione entity) {

        Prenotazione found = storeprenotazione.find(entity.getId()).orElseThrow(() -> new NotFoundException("Prenotazione non trovato. id=" + entity.getId().toString()));

        found = storeprenotazione.save(entity);

        return Response.status(Response.Status.CREATED)
                .entity(found)
                .build();
    }

    @DELETE
    @Path("takeaway/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(description = "Permette la registrazione di un nuovo ristorante")
    @APIResponses({
        @APIResponse(responseCode = "201", description = "Nuovo ristorante creato con successo"),
        @APIResponse(responseCode = "404", description = "Creazione di ristorante fallito")
    })
    @RolesAllowed({"Admin","User"})
    public Response deletetakeaway(@PathParam("id") Long id) {

        Prenotazione found = storeprenotazione.find(id).orElseThrow(() -> new NotFoundException("Prenotazione non trovato. id=" + id.toString()));

        storeprenotazione.delete(id);

        return Response.status(Response.Status.CREATED)
                .entity(found)
                .build();
    }
    
}
