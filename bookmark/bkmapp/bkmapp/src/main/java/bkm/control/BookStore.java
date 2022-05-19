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
import bkm.entity.Book;
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

    public List<Book> findAllByUserCreated(Long id) {

        System.out.println("bookstore");
        System.out.println(id);

        return em.createQuery("select e from Book e where e.usr.id = :id", Book.class)
                .setParameter("id", id)
                .getResultList();

    }

    
    public List<Book> findAllByUser(Long id) {

        System.out.println("bookstore");
        System.out.println(id);

        return em.createQuery("select e from Book e where (e.usr.id = :id) OR (e.usr.id <> :id and e.condiviso = 1)")
                .setParameter("id", id)
                .getResultList();

    }

    public List<JsonObject> findAllByUserJson(Long id) {

        System.out.println("bookstore");
        System.out.println(id);

        List<Book> books = em.createQuery("select e from Book e where (e.usr.id = :id) OR (e.usr.id <> :id and e.condiviso = 1)")
                .setParameter("id", id)
                .getResultList();

        List<JsonObject> jbook = new ArrayList<>();
        
        
        for (Book book : books) {
            
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

    public Optional<Book> find(Long id) {
        Book found = em.find(Book.class, id);
        return found == null ? Optional.empty() : Optional.of(found);
    }

    public Book save(Book entity) {

        return em.merge(entity);

    }

    public void deleteByUser(Long id) {
        findAllByUser(id).stream().map(Book::getId).forEach(this::delete);
    }

    public void delete(Long id) {

        em.remove(em.getReference(Book.class, id));
    }
    
    public void addTag(Book found, String[] tags) {

        Book toupdate = em.find(Book.class, found.getId());
    
        if(tags.length > 0){
            for (String tag : tags) {
                Tag saved = storetag.saveIfNotExists(tag);
                toupdate.getTags().add(saved);
            }
        }
        
        save(toupdate);
    }
    
    public void removeTag(Long id, String tag) {

        final Book toupdate = find(id).get();
        Optional<Tag> found = storetag.byName(tag);
        if (found.isPresent()) {
            toupdate.getTags().remove(found.get());
            save(toupdate);
        }
    }

}
