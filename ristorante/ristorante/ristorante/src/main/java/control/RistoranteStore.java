/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import boundary.mapping.RistoranteOdt;
import entity.OrarioLavoro;
import entity.Prenotazione;
import entity.Ristorante;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

/**
 *
 * @author andrelima
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class RistoranteStore {

    @PersistenceContext
    EntityManager em;

    public List<Ristorante> all() {

        return em.createQuery("select e from Ristorante e where e.cancellato = false", Ristorante.class)
                .getResultList();

    }

    public Optional<Ristorante> find(Long id) {

        Ristorante found = em.find(Ristorante.class, id);

        return found == null ? Optional.empty() : Optional.of(found);

    }

    public Ristorante save(Ristorante entity) {

        return em.merge(entity);

    }

    public void delete(Long id) {
        Ristorante found = em.find(Ristorante.class, id);
        found.setCancellato(true);
        update(found);
    }

    public Ristorante update(Ristorante entity) {

        return em.merge(entity);

    }

    public Optional<Ristorante> findbyNome(String nome) {

        try {

            return Optional.of(
                    em.createQuery("select e from Ristorante e where e.cancellato = false and e.nome = :nome", Ristorante.class)
                            .setParameter("nome", nome)
                            .getSingleResult()
            );
        } catch (NoResultException ex) {

            return Optional.empty();

        }
    }
    
    public Ristorante addOrari(Ristorante ris, OrarioLavoro orari){
    
    
        Ristorante toupdate = em.find(Ristorante.class, ris.getId());
        
        toupdate.getOrarilavoro().add(orari);
        
        return update(toupdate);
    
    }

    
    public RistoranteOdt getSingolo (String id){
    
        Optional<Ristorante> ris = find(Long.parseLong(id));
        
        RistoranteOdt risodt = new RistoranteOdt();

        risodt.setNome(ris.get().getNome());
        risodt.setIndirizzo(ris.get().getIndirizzo());
        
        return risodt;

    }
    
     public List<RistoranteOdt> gettutti (){
    
        List<Ristorante> ris = all();
        List<RistoranteOdt> lrisodt = new ArrayList<>();
        
        
         for (Ristorante ri : ris) {
             
             RistoranteOdt a = new RistoranteOdt();
             a.setNome(ri.getNome());
             a.setIndirizzo(ri.getIndirizzo());
             if(!ri.getOrarilavoro().isEmpty()){
                a.setOrarilavoro(ri.getOrarilavoro());
             }
             lrisodt.add(a);
         }
        
        return lrisodt;

    }
    
}
