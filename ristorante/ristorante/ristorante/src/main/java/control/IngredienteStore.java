/*
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Ingrediente;
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
public class IngredienteStore {
    
          @PersistenceContext
    EntityManager em;

 public List<Ingrediente> all(){
        
        return em.createQuery("select e from Ingrediente e where e.cancellato = false", Ingrediente.class)
                .getResultList();
        
    }
    
    public Optional<Ingrediente> find(Long id){
        
        Ingrediente found = em.find(Ingrediente.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public Ingrediente save(Ingrediente entity){
    
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        Ingrediente found = em.find(Ingrediente.class, id);
        found.setCancellato(true);
        update(found);
    }

    public Ingrediente update(Ingrediente entity) {
       
        return em.merge(entity);
        
    }

    
}
