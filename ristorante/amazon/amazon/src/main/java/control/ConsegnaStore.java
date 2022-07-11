/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Consegna;
import entity.User;
import entity.constant.StatusConsegna;
import java.time.LocalDateTime;
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
public class ConsegnaStore extends BaseStore<Consegna>{
    
    public List<Consegna> all() {

        String query = "";
        query = "select e from Consegna e where e.cancellato = false";

        return em.createQuery(query,Consegna.class).getResultList();

    }

     public Optional<Consegna> find(Long id){
        
        Consegna found = em.find(Consegna.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
     
    public Consegna aggiornaConsegna(Consegna cons, User usr, StatusConsegna st){
        
        Consegna found = em.find(Consegna.class, cons.getId());
        
        found.setUsr(usr);
        
        found.setStconsegna(st);

        if(st == StatusConsegna.Consegnata)
        {
        
            found.setDataconsegna(LocalDateTime.now());
            
        }        
        return super.update(found);
    }
    
}
