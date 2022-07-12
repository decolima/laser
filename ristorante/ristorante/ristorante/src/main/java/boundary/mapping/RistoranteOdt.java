/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package boundary.mapping;

import control.RistoranteStore;
import entity.OrarioLavoro;
import entity.Ristorante;
import java.io.Serializable;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;


/**
 *
 * @author andrelima
 */
public class RistoranteOdt implements Serializable{

    private String nome;
    
    private String indirizzo;
    
    private String responsabile;
    
    private String telefono;
    
    private Set<OrarioLavoro> orarilavoro;    
    

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getResponsabile() {
        return responsabile;
    }

    public void setResponsabile(String responsabile) {
        this.responsabile = responsabile;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Set<OrarioLavoro> getOrarilavoro() {
        return orarilavoro;
    }

    public void setOrarilavoro(Set<OrarioLavoro> orarilavoro) {
        this.orarilavoro = orarilavoro;
    }
    
    
    
    
}
