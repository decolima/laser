/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package adapter;

import entity.Menu;
import control.MenuStore;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.json.bind.adapter.JsonbAdapter;
import javax.ws.rs.NotFoundException;

/**
 *
 * @author andrelima
 */
public class MenuTypeAdapter implements JsonbAdapter<Menu, JsonObject> {

    @Inject
    MenuStore storemenu;

    @Override
    public JsonObject adaptToJson(Menu obj) throws Exception {
        return obj.toJsonSlice();
    }

    @Override
    public Menu adaptFromJson(JsonObject obj) throws Exception {
        if (!obj.containsKey("id")) {
            return null;
        }
        return storemenu.find(obj.getJsonNumber("id").longValue()).orElseThrow(() -> new NotFoundException("Menu adaptFromJson not found"));
    }

}
