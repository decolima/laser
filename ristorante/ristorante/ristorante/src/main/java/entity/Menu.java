/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import adapter.RistoranteTypeAdapter;
import entity.constant.BaseEntity;
import entity.constant.TypeProdotto;
import java.util.Set;
import java.util.TreeSet;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.bind.annotation.JsonbTypeAdapter;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "menu")
public class Menu extends BaseEntity{
    
    private TypeProdotto tipo;
    
    @JsonbTypeAdapter(RistoranteTypeAdapter.class)
    @ManyToOne(optional = false)
    private Ristorante ristorante;
    
    private String descrizione;
    
    boolean disponibile;
    
    boolean takeaway;

    @Enumerated(EnumType.STRING)
    public TypeProdotto getTipo() {
        return tipo;
    }

    public void setTipo(TypeProdotto tipo) {
        this.tipo = tipo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public boolean isDisponibile() {
        return disponibile;
    }

    public void setDisponibile(boolean disponibile) {
        this.disponibile = disponibile;
    }

    public boolean isTakeaway() {
        return takeaway;
    }

    public void setTakeaway(boolean takeaway) {
        this.takeaway = takeaway;
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
