/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.ProdottoPrezzo;
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
public class ProdottoPrezzoStore {
    
          @PersistenceContext
    EntityManager em;

 public List<ProdottoPrezzo> all(){
        
        return em.createQuery("select e from ProdottoPrezzo e where e.cancellato = false", ProdottoPrezzo.class)
                .getResultList();
        
    }
    
    public Optional<ProdottoPrezzo> find(Long id){
        
        ProdottoPrezzo found = em.find(ProdottoPrezzo.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public ProdottoPrezzo save(ProdottoPrezzo entity){
    
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        ProdottoPrezzo found = em.find(ProdottoPrezzo.class, id);
        found.setCancellato(true);
        update(found);
    }

    public ProdottoPrezzo update(ProdottoPrezzo entity) {
       
        return em.merge(entity);
        
    }

    
}
