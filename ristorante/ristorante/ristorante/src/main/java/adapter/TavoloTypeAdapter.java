/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package adapter;

import control.TavoloStore;
import entity.Tavolo;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.json.bind.adapter.JsonbAdapter;
import javax.ws.rs.NotFoundException;

/**
 *
 * @author andrelima
 */
public class TavoloTypeAdapter implements JsonbAdapter<Tavolo, JsonObject>  {

    @Inject
    TavoloStore storertavolo;

  @Override
    public JsonObject adaptToJson(Tavolo obj) throws Exception {
        return obj.toJsonSlice();
    }

    @Override
    public Tavolo adaptFromJson(JsonObject obj) throws Exception {
        if (!obj.containsKey("id")) {
            return null;
        }
        return storertavolo.find(obj.getJsonNumber("id").longValue()).orElseThrow(() -> new NotFoundException("Ristorante.adaptFromJson not found"));
    }

    
}
