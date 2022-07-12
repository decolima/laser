/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import boundary.mapping.Credential;
import entity.Prenotazione;
import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import security.SecurityEncoding;

/**
 *
 * @author andrelima
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class PrenotazioneStore {
    
      @PersistenceContext
    EntityManager em;

 public List<Prenotazione> all(){
        
        return em.createQuery("select e from Prenotazione e where e.cancellato = false", Prenotazione.class)
                .getResultList();
        
    }
    
    public Optional<Prenotazione> find(Long id){
        
        Prenotazione found = em.find(Prenotazione.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public Prenotazione save(Prenotazione entity){
    
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        Prenotazione found = em.find(Prenotazione.class, id);
        found.setCancellato(true);
        update(found);
    }

    public Prenotazione update(Prenotazione entity) {
       
        return em.merge(entity);
        
    }
    
    
    public List<Prenotazione> allCliente(String nome, String telefono) {
    
        return em.createQuery("select e from Prenotazione e where e.cancellato = false and e.nome LIKE %:nome% and e.telefono LIKE %:telefono%", Prenotazione.class)
            .setParameter("nome", nome)
            .setParameter("telefono", telefono)
            .getResultList();
    }

    

    
}
