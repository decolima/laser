/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import entity.constant.TypeProdotto;
import java.sql.Blob;
import java.util.Set;
import java.util.TreeSet;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "prodotto")
public class Prodotto extends BaseEntity {
    
    @Enumerated(EnumType.STRING)
    private TypeProdotto tipo;
    
    private String nome;
    
    private String descrizione;
    
    private String riguardo;
    
    private Blob image;

    public Blob getImage() {
        return image;
    }

    public void setImage(Blob image) {
        this.image = image;
    }
    
    

    public String getRiguardo() {
        return riguardo;
    }

    public void setRiguardo(String riguardo) {
        this.riguardo = riguardo;
    }
        
    
    @JsonbTransient
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "prod_ingred", 
               joinColumns = @JoinColumn(name = "prod_id"), 
               inverseJoinColumns = @JoinColumn(name = "ingred_id"))
    private Set<Ingrediente> composizione = new TreeSet<>();

    public Set<Ingrediente> getComposizione() {
        return composizione;
    }

    public void setComposizione(Set<Ingrediente> composizione) {
        this.composizione = composizione;
    }
    
    

    public TypeProdotto getTipo() {
        return tipo;
    }

    public void setTipo(TypeProdotto tipo) {
        this.tipo = tipo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }
    
    
    public JsonObject toJsonSlice() {

        return Json.createObjectBuilder()
                .add("id", this.id)
                .build();
    }
    
}
