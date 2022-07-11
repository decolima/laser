/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.OrarioLavoro;
import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

/**
 *
 * @author andrelima
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class OrarioLavoroStore {
    
          @PersistenceContext
    EntityManager em;

 public List<OrarioLavoro> all(){
        
        return em.createQuery("select e from OrarioLavoro e where e.cancellato = false", OrarioLavoro.class)
                .getResultList();
        
    }
    
    public Optional<OrarioLavoro> find(Long id){
        
        OrarioLavoro found = em.find(OrarioLavoro.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public OrarioLavoro save(OrarioLavoro entity){
    
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        OrarioLavoro found = em.find(OrarioLavoro.class, id);
        found.setCancellato(true);
        update(found);
    }

    public OrarioLavoro update(OrarioLavoro entity) {
       
        return em.merge(entity);
        
    }

    
}
