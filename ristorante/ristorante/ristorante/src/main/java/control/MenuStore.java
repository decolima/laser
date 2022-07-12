/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Menu;
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
public class MenuStore {
    
          @PersistenceContext
    EntityManager em;

 public List<Menu> all(){
        
        return em.createQuery("select e from Menu e where e.cancellato = false", Menu.class)
                .getResultList();
        
    }
    
    public Optional<Menu> find(Long id){
        
        Menu found = em.find(Menu.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public Menu save(Menu entity){
    
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        Menu found = em.find(Menu.class, id);
        found.setCancellato(true);
        update(found);
    }

    public Menu update(Menu entity) {
       
        return em.merge(entity);
        
    }
    
    

    
}
