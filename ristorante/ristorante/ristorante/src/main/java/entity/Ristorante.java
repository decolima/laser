/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import java.util.Set;
import java.util.TreeSet;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "ristorante")
public class Ristorante extends BaseEntity {
    
    @NotBlank
    private String nome;
    
    @NotBlank
    private String indirizzo;
    
    @NotBlank
    private String responsabile;
    
    @NotBlank
    private String telefono;
    
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "ris_orario", 
               joinColumns = @JoinColumn(name = "ris_id"), 
               inverseJoinColumns = @JoinColumn(name = "orario_id"))
    private Set<OrarioLavoro> orarilavoro = new TreeSet<>();

    
    public Set<OrarioLavoro> getOrarilavoro() {
        return orarilavoro;
    }

    @JsonbTransient
    public void setOrarilavoro(Set<OrarioLavoro> orarilavoro) {
        this.orarilavoro = orarilavoro;
    }
    

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getResponsabile() {
        return responsabile;
    }

    public void setResponsabile(String responsabile) {
        this.responsabile = responsabile;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public JsonObject toJsonSlice() {

        return Json.createObjectBuilder()
                .add("id", this.id)
                .build();
    }
    
}
