/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import adapter.RistoranteTypeAdapter;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.bind.annotation.JsonbTransient;
import javax.json.bind.annotation.JsonbTypeAdapter;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "tavolo")
public class Tavolo extends BaseEntity{
    
    @NotNull
    private Integer posti;
    
    @NotNull
    private boolean occupato;
    
    @JsonbTypeAdapter(RistoranteTypeAdapter.class)
    @ManyToOne(optional = false)
    Ristorante ristorante;

    public Integer getPosti() {
        return posti;
    }

    public void setPosti(Integer posti) {
        this.posti = posti;
    }

    public boolean isOccupato() {
        return occupato;
    }

    @JsonbTransient
    public void setOccupato(boolean occupato) {
        this.occupato = occupato;
    }

    public Ristorante getRistorante() {
        return ristorante;
    }

    public void setRistorante(Ristorante ristorante) {
        this.ristorante = ristorante;
    }
    
    public JsonObject toJsonSlice() {

        return Json.createObjectBuilder()
                .add("id", this.id)
                .build();
    }
    
    
}
