/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import control.repository.IBase;
import java.util.List;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

/**
 *
 * @author andrelima
 * @param <TEntity>
 */
//@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class BaseStore<TEntity>{

    @PersistenceContext
    EntityManager em;


    public TEntity save(TEntity obj) {
       
        return em.merge(obj);
        
    }

   
    public TEntity update(TEntity obj) {

        return em.merge(obj);
    }


    public void remove(TEntity obj) {

        em.remove(obj);
        
    }

    /*
    @Override
    public List<TEntity> GetAll() {

        String query = "";
        query = "select e from "
                + TEntity.getClass().toString()
                + "e where e.cancellato = false";

        return em.createQuery(query, TEntity.getClass()).getResultList();

    }

    @Override
    public TEntity GetById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
      */  
}
