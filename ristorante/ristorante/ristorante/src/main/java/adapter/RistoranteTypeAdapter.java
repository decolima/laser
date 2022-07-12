/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package adapter;

import entity.Ristorante;
import control.RistoranteStore;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.json.bind.adapter.JsonbAdapter;
import javax.ws.rs.NotFoundException;

/**
 *
 * @author andrelima
 */
public class RistoranteTypeAdapter implements JsonbAdapter<Ristorante, JsonObject> {

    @Inject
    RistoranteStore storeristorante;

    @Override
    public JsonObject adaptToJson(Ristorante obj) throws Exception {
        return obj.toJsonSlice();
    }

    @Override
    public Ristorante adaptFromJson(JsonObject obj) throws Exception {
        if (!obj.containsKey("id")) {
            return null;
        }
        return storeristorante.find(obj.getJsonNumber("id").longValue()).orElseThrow(() -> new NotFoundException("Ristorante.adaptFromJson not found"));
    }

}
