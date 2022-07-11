/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.constant.BaseEntity;
import entity.constant.StatusTakeAway;
import java.time.LocalDateTime;
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
@Table(name = "prodottotakeaway")
public class ProdottoTakeAway extends BaseEntity{
    
    LocalDateTime dtcreazione;
    
    @ManyToOne(optional = false)
    private ProdottoPrezzo prodotto;
    
    private Integer quantita;
    
    @Enumerated(EnumType.STRING)
    private StatusTakeAway statustake;

    public LocalDateTime getDtcreazione() {
        return dtcreazione;
    }

    public void setDtcreazione(LocalDateTime dtcreazione) {
        this.dtcreazione = dtcreazione;
    }

    public ProdottoPrezzo getProdotto() {
        return prodotto;
    }

    public void setProdotto(ProdottoPrezzo prodotto) {
        this.prodotto = prodotto;
    }

    public StatusTakeAway getStatustake() {
        return statustake;
    }

    public void setStatustake(StatusTakeAway statustake) {
        this.statustake = statustake;
    }
    
    
    
    
    
}
