/*
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Prodotto;
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
public class ProdottoStore {
    
          @PersistenceContext
    EntityManager em;

 public List<Prodotto> all(){
        
        return em.createQuery("select e from Prodotto e where e.cancellato = false", Prodotto.class)
                .getResultList();
        
    }
    
    public Optional<Prodotto> find(Long id){
        
        Prodotto found = em.find(Prodotto.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public Prodotto save(Prodotto entity){
    
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        Prodotto found = em.find(Prodotto.class, id);
        found.setCancellato(true);
        update(found);
    }

    public Prodotto update(Prodotto entity) {
       
        return em.merge(entity);
        
    }

    
}
