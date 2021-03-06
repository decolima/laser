/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import entity.User;
import java.util.List;
import java.util.Optional;
import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import security.SecurityEncoding;
import boundary.mapping.Credential;
import javax.persistence.NoResultException;

/**
 *
 * @author tss
 */
@RequestScoped
@Transactional(Transactional.TxType.REQUIRED)
public class UserStore {
    
    @PersistenceContext
    EntityManager em;
    
      
    
    public List<User> all(){
        
        return em.createQuery("select e from User e where e.cancellato = false order by e.lastName").getResultList();
        
    }
    
    public Optional<User> find(Long id){
        
        User found = em.find(User.class, id);
       
        return found == null ? Optional.empty() : Optional.of(found);
        
    }
    
    
    public User save(User entity){
    
        entity.setPwd(SecurityEncoding.shaHash(entity.getPwd()));
        return em.merge(entity);
        
    }

    public void delete(Long id) {
        User found = em.find(User.class, id);
        found.setCancellato(true);
        update(found);
    }

    public User update(User entity) {
        
        if (entity.getPwd().length() < 15){
            entity.setPwd(SecurityEncoding.shaHash(entity.getPwd()));
        }
        return em.merge(entity);
        
    }
    
    
    public List<User> allPaginated(int page, int size) {
    return em.createQuery("select e from User e order by e.lastName where e.cancellato = false", User.class)
            .setFirstResult((page - 1) * size)
            .setMaxResults(size)
            .getResultList();
    }

    public Optional<User> login(Credential credential) {
        try{
            
            return Optional.of(
                    em.createQuery("select e from User e where e.email = :usr and e.pwd = :pwd and e.cancellato = false", User.class)
                    .setParameter("usr", credential.usr)
                    .setParameter("pwd", SecurityEncoding.shaHash(credential.pwd))
                    .getSingleResult()
                    );
            
        } catch (NoResultException ex) {
            
            return Optional.empty();                    
            
        }
            
    }
    
    public Optional<User> findUserbyLogin(String login) {
        try{
            
            return Optional.of(
                    em.createQuery("select e from User e where e.email = :login and e.cancellato = false", User.class)
                    .setParameter("login", login)
                    .getSingleResult()
                    );
            
        } catch (NoResultException ex) {
            
            return Optional.empty();                    
            
        }
            
    }
    
    
    
}
