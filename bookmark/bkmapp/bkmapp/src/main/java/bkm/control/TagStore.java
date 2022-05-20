/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bkm.control;

import bkm.entity.Tag;
import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

/**
 *
 * @author tss
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class TagStore {

    @PersistenceContext
    EntityManager em;

    

    public List<Tag> all() {

        return em.createQuery("select e from Tag e where e.cancellato = false").getResultList();

    }

    public Optional<Tag> find(Long id) {

        Tag found = em.find(Tag.class, id);

        return found == null ? Optional.empty() : Optional.of(found);

    }

    public Tag save(Tag entity) {

        return em.merge(entity);

    }

    public void delete(Long id) {       
        Tag found = em.getReference(Tag.class, id);
        found.setCancellato(true);
        this.save(found);
    }
   
     public Tag saveIfNotExists(String tag) {
        Optional<Tag> found = byName(tag);
        if (found.isPresent()) {
            
            if(found.get().isCancellato() == true){
                found.get().setCancellato(false);
                this.save(found.get());
            }
            
            return found.get();
        }
        return this.save(new Tag(tag));
    }

 
    public Optional<Tag> byName(String tag) {
        try {
            return Optional.of(em.createQuery("select e from Tag e where TRIM(LOWER(e.name))= :name", Tag.class)
                    .setParameter("name", tag.trim().toLowerCase())
                    .getSingleResult());
        } catch (NoResultException ex) {
            return Optional.empty();
        }
    }


}
