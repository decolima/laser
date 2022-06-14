/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bkm.control;

import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import bkm.entity.Bookmarks;
import bkm.entity.Tag;
import java.util.ArrayList;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;

/**
 *
 * @author tss
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class BookStore {

    @PersistenceContext
    EntityManager em;

    @Inject
    TagStore storetag;

    public List<Bookmarks> findAllByUserCreated(Long id) {

        System.out.println("bookstore");
        System.out.println(id);

        return em.createQuery("select e from Bookmarks e where e.usr.id = :id and e.cancellato = false", Bookmarks.class)
                .setParameter("id", id)
                .getResultList();

    }
    
    public List<Bookmarks> findAllByUser(Long id) {

        System.out.println("bookstore");
        System.out.println(id);

        return em.createQuery("select e from Bookmarks e where (e.usr.id = :id) OR (e.usr.id <> :id and e.condiviso = 1) "
                + "and e.cancellato = false and e.usr.cancellato = false", Bookmarks.class)
                .setParameter("id", id)
                .getResultList();

    }
 
    public List<JsonObject> findAllForValidating(int page, int size) {

        List<Bookmarks> books = em.createQuery("select e from Bookmarks e where e.condiviso = 1 "
                                            + "and e.cancellato = false "
                                            + "and e.usr.cancellato = false "
                                            + "and e.status = 'Nuovo'", Bookmarks.class)
                .setFirstResult((page - 1) * size)
                .setMaxResults(size)
                .getResultList();

        List<JsonObject> jbook = new ArrayList<>();
        
        
        for (Bookmarks book : books) {
            
            JsonObject jb = Json.createObjectBuilder()
                .add("IdBookMk", book.getId().toString())
                .add("descrizione", book.getDescrizione())
                .add("link", book.getLink())
                .add("Utente", book.getUsr().getFirstName())
                .add("condiviso", book.getCondiviso())
                .add("DtCreazione", book.getCreazione().toString())
                .add("Tags", book.tagstostring())
                .build();
            
            jbook.add(jb);
        }
        
        return jbook;
        
    }
     
    public List<JsonObject> findAllByUserJson(Long id, int page, int size) {

        List<Bookmarks> books = em.createQuery("select e from Bookmarks e where ((e.usr.id = :id) OR (e.usr.id <> :id and e.condiviso = 1)) "
                + "and e.cancellato = false and e.usr.cancellato = false "
                + "order by e.creazione desc", Bookmarks.class)
                .setParameter("id", id)
                .setFirstResult((page - 1) * size)
                .setMaxResults(size)
                .getResultList();

        List<JsonObject> jbook = new ArrayList<>();
        
        
        for (Bookmarks book : books) {
            
            JsonObject jb = Json.createObjectBuilder()
                .add("idbkm", book.getId().toString())
                .add("descrizione", book.getDescrizione())
                .add("link", book.getLink())
                .add("utente", book.getUsr().getFirstName())
                .add("condiviso", book.getCondiviso())
                .add("dtcreazione", book.getCreazione().toString())
                .add("status", book.getStatus().toString())
                .add("dtaggiornamento", book.getAggiornamento().toString())
                .add("utenteagg", book.getUsragg().getFirstName())
                .add("motivorim", book.getMotivorim())    
                .add("Tags", book.tagstostring())
                .add("mail", book.getUsr().getEmail())  
                .build();
            
            jbook.add(jb);
        }
        
        return jbook;
        
    }

    public List<JsonObject> findBkmsJson(Long id) {

        List<Bookmarks> books = em.createQuery("select e from Bookmarks e where e.id = :id", Bookmarks.class)
                .setParameter("id", id)
                .getResultList();

        
        List<JsonObject> jbook = new ArrayList<>();
        
        
        for (Bookmarks book : books) {
            
            JsonObject jb = Json.createObjectBuilder()
                .add("idbkm", book.getId().toString())
                .add("descrizione", book.getDescrizione())
                .add("link", book.getLink())
                .add("utente", book.getUsr().getFirstName())
                .add("condiviso", book.getCondiviso())
                .add("dtcreazione", book.getCreazione().toString())
                .add("status", book.getStatus().toString())
                .add("dtaggiornamento", book.getAggiornamento().toString())
                .add("utenteagg", book.getUsragg().getFirstName())
                .add("motivorim", book.getMotivorim())    
                .add("Tags", book.tagstostring())
                .add("mail", book.getUsr().getEmail())  
                .build();
            
            jbook.add(jb);
        }
        
        return jbook;
    }

    public Optional<Bookmarks> find(Long id) {
        Bookmarks found = em.find(Bookmarks.class, id);
        return found == null ? Optional.empty() : Optional.of(found);
    }

    public Bookmarks save(Bookmarks entity) {

        return em.merge(entity);

    }

    public void deleteByUser(Long id) {
        findAllByUser(id).stream().map(Bookmarks::getId).forEach(this::delete);
    }

    public void delete(Long id) {
        
        Bookmarks found = em.find(Bookmarks.class, id);
        found.setCancellato(true);
        save(found);
        
    }
    
    public void addTag(Bookmarks found, String[] tags) {

        Bookmarks toupdate = em.find(Bookmarks.class, found.getId());
    
        if(tags.length > 0){
            for (String tag : tags) {
                Tag saved = storetag.saveIfNotExists(tag);
                toupdate.getTags().add(saved);
            }
        }
        
        save(toupdate);
    }
    
    public void removeTag(Long id, String tag) {

        final Bookmarks toupdate = find(id).get();
        Optional<Tag> found = storetag.byName(tag);
        if (found.isPresent()) {
            toupdate.getTags().remove(found.get());
            save(toupdate);
        }
    }

}
