/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import entity.constant.GiornoLavoro;
import java.time.LocalTime;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;

/**
 *
 * @author andrelima
 */
@Entity
@Table(name = "orariolavoro")
public class OrarioLavoro extends BaseEntity {
    
    @Enumerated(EnumType.STRING)
    private GiornoLavoro giorno;
    
    private LocalTime inizio;
    
    private LocalTime fine;

    public GiornoLavoro getGiorno() {
        return giorno;
    }

    public void setGiorno(GiornoLavoro giorno) {
        this.giorno = giorno;
    }

    public LocalTime getInizio() {
        return inizio;
    }

    public void setInizio(LocalTime inizio) {
        this.inizio = inizio;
    }

    public LocalTime getFine() {
        return fine;
    }

    public void setFine(LocalTime fine) {
        this.fine = fine;
    }
    
    
}
