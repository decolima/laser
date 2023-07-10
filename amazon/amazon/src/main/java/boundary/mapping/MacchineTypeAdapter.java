/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package boundary.mapping;

import control.MacchineStore;
import entity.Macchine;
import java.util.Set;
import java.util.stream.Collectors;
import javax.inject.Inject;
import javax.json.bind.adapter.JsonbAdapter;
import javax.ws.rs.NotFoundException;

/**
 *
 * @author andrelima
 */
public class MacchineTypeAdapter implements JsonbAdapter<Set<Macchine>, Set<Long>> {

    @Inject
    MacchineStore store;

 
    @Override
    public Set<Long> adaptToJson(Set<Macchine> obj) throws Exception {
        return obj.stream().map(Macchine::getId).collect(Collectors.toSet());
    }

    @Override
    public Set<Macchine> adaptFromJson(Set<Long> obj) throws Exception {
        
        System.out.println(obj);
        
        return obj.stream().map(v -> store.find(v).orElseThrow(() -> new NotFoundException("MacchineTypeAdapter.adaptFromJson not found"))).collect(Collectors.toSet());
        
        /*
        Set<Macchine> found = new TreeSet();
        
        for(Long i : obj){
            
            System.out.println(i);
            
            Macchine m = store.findbyid(i);
            
            System.out.println(m.getDescrizione());
            
            
            found.add(m);
        }
        
        return found;
        //return obj.stream().map(v -> store.findbyid(v)).collect(Collectors.toSet());
        */
    }
    
}
