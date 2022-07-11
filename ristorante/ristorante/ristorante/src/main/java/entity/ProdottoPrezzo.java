/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import adapter.MenuTypeAdapter;
import adapter.ProdottoTypeAdapter;
import entity.constant.BaseEntity;
import javax.json.Json;
import javax.json.JsonObject;
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
@Table(name = "ProdottoPrezzo")
public class ProdottoPrezzo extends BaseEntity{
    
    @JsonbTypeAdapter(ProdottoTypeAdapter.class)
    @ManyToOne(optional = false)
    private Prodotto prodotto;
    
    @JsonbTypeAdapter(MenuTypeAdapter.class)
    @ManyToOne(optional = false)
    private Menu menu;
    
    @NotNull
    private Long prezzo;
    
    boolean takeaway;

    public Prodotto getProdotto() {
        return prodotto;
    }

    public void setProdotto(Prodotto prodotto) {
        this.prodotto = prodotto;
    }

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public Long getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(Long prezzo) {
        this.prezzo = prezzo;
    }

    public boolean isTakeaway() {
        return takeaway;
    }

    public void setTakeaway(boolean takeaway) {
        this.takeaway = takeaway;
    }
    
    public JsonObject toJsonSlice() {

        return Json.createObjectBuilder()
                .add("id", this.id)
                .build();
    }
    
}
