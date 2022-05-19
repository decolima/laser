/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bkm.entity;

import bkm.adapter.UserTypeAdapter;
import bkm.boundary.UsersResources;
import bkm.boundary.BooksResources;
import java.time.LocalDate;
import java.util.Set;
import java.util.TreeSet;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.bind.annotation.JsonbTransient;
import javax.json.bind.annotation.JsonbTypeAdapter;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.ws.rs.core.UriBuilder;

/**
 *
 * @author tss
 */

@NamedNativeQueries({
    @NamedNativeQuery(name = Book.BOOK_ALL,
            query = "SELECT * FROM book where (usr_id = :id) or (usr_id <> :id and condiviso = 1)")
})


@Entity
@Table(name = "book")
public class Book extends BaseEntity {
    
    public static final String BOOK_ALL = "Book.All";
        
    @NotBlank
    @Column(nullable = false)
    private String descrizione;
    
    @NotBlank
    @Column(nullable = false)
    private String link;
    
    @JsonbTransient
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "book_tag", 
               joinColumns = @JoinColumn(name = "book_id"), 
               inverseJoinColumns = @JoinColumn(name = "tag_id"))
    private Set<Tag> tags = new TreeSet<>();
    
    
    //@JsonbTypeAdapter(UserTypeAdapter.class)
    @JsonbTransient
    @ManyToOne(optional = false)
    private User usr;
    
    @NotNull
    @Column(nullable = false)
    private char condiviso;

    //@NotBlank
    @Column(nullable = false)
    private LocalDate creazione;

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Set<Tag> getTags() {
        return tags;
    }

    public void setTags(Set<Tag> tags) {
        this.tags = tags;
    }

    public User getUsr() {
        return usr;
    }

    
    public void setUsr(User usr) {
        this.usr = usr;
    }

    public char getCondiviso() {
        return condiviso;
    }

    public void setCondiviso(char condiviso) {
        this.condiviso = condiviso;
    }

    public LocalDate getCreazione() {
        return creazione;
    }

    @JsonbTransient
    public void setCreazione(LocalDate creazione) {
        this.creazione = creazione;
    }

    @Override
    public String toString() {
        return "Book{" + "descrizione=" + descrizione + ", link=" + link + ", tags=" + tags + ", usr=" + usr + ", condiviso=" + condiviso + ", creazione=" + creazione + '}';
    }
    
    
    
    public JsonObject toJsonSliceBooks() {

        
        return Json.createObjectBuilder()
                .add("descrizione", this.toString())
                .build();
    }   
    
    
    public String tagstostring(){
        
        String res = "";
        
        for (Tag tag : tags) {
            res += "#" + tag.getName();
        }
        
        return res;
        
    }
            
    
    
    
    
    
    
}
