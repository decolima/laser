/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.Consegna;
import entity.Corriere;
import java.util.List;
import javax.enterprise.context.RequestScoped;
import javax.transaction.Transactional;

/**
 *
 * @author andrelima
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class CorriereStore extends BaseStore<Corriere>{
    
    
    public List<Corriere> all() {

        return em.createQuery("select e from Corriere e where e.cancellato = false",Corriere.class).getResultList();

    }
    
}
