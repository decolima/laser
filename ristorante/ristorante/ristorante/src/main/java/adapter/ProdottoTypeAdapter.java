/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package adapter;

import entity.Prodotto;
import control.ProdottoStore;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.json.bind.adapter.JsonbAdapter;
import javax.ws.rs.NotFoundException;

/**
 *
 * @author andrelima
 */
public class ProdottoTypeAdapter implements JsonbAdapter<Prodotto, JsonObject> {

    @Inject
    ProdottoStore storeprodotto;

    @Override
    public JsonObject adaptToJson(Prodotto obj) throws Exception {
        return obj.toJsonSlice();
    }

    @Override
    public Prodotto adaptFromJson(JsonObject obj) throws Exception {
        if (!obj.containsKey("id")) {
            return null;
        }
        return storeprodotto.find(obj.getJsonNumber("id").longValue()).orElseThrow(() -> new NotFoundException("Prodotto.adaptFromJson not found"));
    }

}
