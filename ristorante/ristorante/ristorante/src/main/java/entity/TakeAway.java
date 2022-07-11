/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import entity.constant.StatusTakeAway;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.TreeSet;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "takeaway")
public class TakeAway extends BaseEntity{
    
    private LocalDateTime dtcreazione;
    
    @ManyToOne(optional = false)
    private Menu menu;
    
    private LocalDateTime dtconsegna;
    
    private String nomecliente;
    
    @ManyToOne(optional = true)
    private User utente;
    
    private Float valore;
    
    private StatusTakeAway statustake;
    

    public LocalDateTime getDtcreazione() {
        return dtcreazione;
    }

    public void setDtcreazione(LocalDateTime dtcreazione) {
        this.dtcreazione = dtcreazione;
    }

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public LocalDateTime getDtconsegna() {
        return dtconsegna;
    }

    public void setDtconsegna(LocalDateTime dtconsegna) {
        this.dtconsegna = dtconsegna;
    }

    public String getNomecliente() {
        return nomecliente;
    }

    public void setNomecliente(String nomecliente) {
        this.nomecliente = nomecliente;
    }

    public User getUtente() {
        return utente;
    }

    public void setUtente(User utente) {
        this.utente = utente;
    }

    public Float getValore() {
        return valore;
    }

    public void setValore(Float valore) {
        this.valore = valore;
    }

    public StatusTakeAway getStatustake() {
        return statustake;
    }

    public void setStatustake(StatusTakeAway statustake) {
        this.statustake = statustake;
    }
    
    
    
    
}
