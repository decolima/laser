/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import entity.constant.StatusPrenotazione;
import adapter.TavoloTypeAdapter;
import java.time.LocalDateTime;
import javax.json.bind.annotation.JsonbTransient;
import javax.json.bind.annotation.JsonbTypeAdapter;
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
@Table(name = "prenotazione")
public class Prenotazione extends BaseEntity{

    @JsonbTypeAdapter(TavoloTypeAdapter.class)
    @ManyToOne(optional = false)
    private Tavolo tavolo;
    
    @NotNull
    private LocalDateTime inizio;
    
    private LocalDateTime datap;
    
    @NotBlank
    private String nome;
    
    @NotBlank
    private String telefono;
    
    @Enumerated(EnumType.STRING)
    @NotNull
    private StatusPrenotazione stprenotazione;

    public Tavolo getTavolo() {
        return tavolo;
    }

    public void setTavolo(Tavolo tavolo) {
        this.tavolo = tavolo;
    }

    public LocalDateTime getInizio() {
        return inizio;
    }

    public void setInizio(LocalDateTime inizio) {
        this.inizio = inizio;
    }

    public LocalDateTime getDatap() {
        return datap;
    }

    @JsonbTransient
    public void setDatap(LocalDateTime datap) {
        this.datap = datap;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public StatusPrenotazione getStprenotazione() {
        return stprenotazione;
    }

    public void setStprenotazione(StatusPrenotazione stprenotazione) {
        this.stprenotazione = stprenotazione;
    }

       
    
}
