/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Corriere;
import entity.Macchine;
import entity.User;
import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.transaction.Transactional;

/**
 *
 * @author andrelima
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class MacchineStore extends BaseStore<Macchine>{
    
      public List<Macchine> all() {

        return em.createQuery("select e from Macchine e where e.cancellato = false",Macchine.class).getResultList();

    }
    
    public Optional<Macchine> find(Long id){
        
        Macchine found = em.find(Macchine.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
        public Macchine findbyid(Long id){
        
        return em.find(Macchine.class, id);
       
   
    }
      
}
