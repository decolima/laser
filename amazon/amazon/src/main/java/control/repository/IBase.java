/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package control.repository;

import java.util.List;

/**
 *
 * @author andrelima
 */
public interface IBase<TEntity>   {
    
    TEntity save(TEntity obj);

    TEntity update(TEntity obj);

    void remove(TEntity obj);

   // List<TEntity> GetAll();

    //TEntity GetById(int id);
    
}
