/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import boundary.UsersResources;
import entity.constant.BaseEntity;
import javax.json.Json;
import javax.json.JsonObject;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.ws.rs.core.UriBuilder;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "macchine")
public class Macchine  extends BaseEntity implements Comparable<Macchine> {
    
    @NotBlank
    private String descrizione; 

    @NotBlank
    private String anno;
    
    private boolean disponibile;

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getAnno() {
        return anno;
    }

    public void setAnno(String anno) {
        this.anno = anno;
    }

    public boolean isDisponibile() {
        return disponibile;
    }

    public void setDisponibile(boolean disponibile) {
        this.disponibile = disponibile;
    }
    
    public JsonObject toJsonSlice() {

        return Json.createObjectBuilder()
                .add("id", this.id)
                .build();
    }

    @Override
    public int compareTo(Macchine o) {
 
        return this.getDescrizione().compareTo(o.getDescrizione());
        
    }


   
    
}
