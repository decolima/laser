/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import boundary.mapping.MacchineTypeAdapter;
import entity.constant.BaseEntity;
import java.time.LocalDate;
import java.util.Set;
import java.util.TreeSet;
import javax.json.bind.annotation.JsonbTransient;
import javax.json.bind.annotation.JsonbTypeAdapter;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "corriere")
public class Corriere extends BaseEntity  {
    
    @NotBlank
    private String nome; 

    @NotNull
    private String nrpg;

    @NotNull
    private String tipopg;

    @JsonbTransient
    //@NotNull
    private LocalDate scadenzapg;

    @JsonbTypeAdapter(MacchineTypeAdapter.class)
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "corr_macc", 
               joinColumns = @JoinColumn(name = "co_id"), 
               inverseJoinColumns = @JoinColumn(name = "ma_id"))
    private Set<Macchine> macchine = new TreeSet<>();

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNrpg() {
        return nrpg;
    }

    public void setNrpg(String nrpg) {
        this.nrpg = nrpg;
    }

    public String getTipopg() {
        return tipopg;
    }

    public void setTipopg(String tipopg) {
        this.tipopg = tipopg;
    }

    public LocalDate getScadenzapg() {
        return scadenzapg;
    }

    public void setScadenzapg(LocalDate scadenzapg) {
        this.scadenzapg = scadenzapg;
    }

    public Set<Macchine> getMacchine() {
        return macchine;
    }

    public void setMacchine(Set<Macchine> macchine) {
        this.macchine = macchine;
    }

    


}
