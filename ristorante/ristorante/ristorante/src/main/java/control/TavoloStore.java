/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Tavolo;
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
public class TavoloStore {

    @PersistenceContext
    EntityManager em;

    public List<Tavolo> all() {

        return em.createQuery("select e from Tavolo e where e.cancellato = false", Tavolo.class)
                .getResultList();

    }

    public Optional<Tavolo> find(Long id) {

        Tavolo found = em.find(Tavolo.class, id);

        return found == null ? Optional.empty() : Optional.of(found);

    }

    public Tavolo save(Tavolo entity) {

        return em.merge(entity);

    }

    public void delete(Long id) {
        Tavolo found = em.find(Tavolo.class, id);
        found.setCancellato(true);
        update(found);
    }

    public Tavolo update(Tavolo entity) {

        return em.merge(entity);

    }

}
