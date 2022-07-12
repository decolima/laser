/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import entity.constant.StatusConsegna;
import java.time.LocalDateTime;
import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 *
 * @author andrelima
 */

@Entity
@Table(name = "consegna")
public class Consegna extends BaseEntity {

@NotBlank
private String idamazon; 
@NotNull
private Float pesopaco;
@NotBlank
private String dimensione;
@JsonbTransient
private LocalDateTime dataconsegna;
@NotBlank
private String indirizzo;
@Enumerated(EnumType.STRING)
private StatusConsegna stconsegna;
@JsonbTransient
@ManyToOne(optional = true)
private User usr;

    public User getUsr() {
        return usr;
    }

    public void setUsr(User usr) {
        this.usr = usr;
    }

    public String getIdamazon() {
        return idamazon;
    }

    public void setIdamazon(String idamazon) {
        this.idamazon = idamazon;
    }

    public Float getPesopaco() {
        return pesopaco;
    }

    public void setPesopaco(Float pesopaco) {
        this.pesopaco = pesopaco;
    }

    public String getDimensione() {
        return dimensione;
    }

    public void setDimensione(String dimensione) {
        this.dimensione = dimensione;
    }

    public LocalDateTime getDataconsegna() {
        return dataconsegna;
    }

    public void setDataconsegna(LocalDateTime dataconsegna) {
        this.dataconsegna = dataconsegna;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public StatusConsegna getStconsegna() {
        return stconsegna;
    }

    public void setStconsegna(StatusConsegna stconsegna) {
        this.stconsegna = stconsegna;
    }



    
}
