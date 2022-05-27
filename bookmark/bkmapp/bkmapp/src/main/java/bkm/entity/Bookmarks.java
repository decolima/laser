/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bkm.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.TreeSet;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
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
    @NamedNativeQuery(name = Bookmarks.BOOK_ALL,
            query = "SELECT * FROM book where (usr_id = :id) or (usr_id <> :id and condiviso = 1)")
})


@Entity
@Table(name = "book")
public class Bookmarks extends BaseEntity {
    
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
    private boolean condiviso;

    @Enumerated(EnumType.STRING)
    @NotNull
    private StatusBkms status;
    
    @NotNull
    private String motivorim;
    
    //@NotBlank
    @Column(nullable = false)
    private LocalDateTime creazione;

    //@NotBlank
    @Column(nullable = false)
    private LocalDateTime aggiornamento;

    @JsonbTransient
    @ManyToOne(optional = false)
    private User usragg;
    

    public LocalDateTime getAggiornamento() {
        return aggiornamento;
    }

    public void setAggiornamento(LocalDateTime aggiornamento) {
        this.aggiornamento = aggiornamento;
    }

    public User getUsragg() {
        return usragg;
    }

    public void setUsragg(User usragg) {
        this.usragg = usragg;
    }
    
    
    
    public String getMotivorim() {
        return motivorim;
    }

    public void setMotivorim(String motivorim) {
        this.motivorim = motivorim;
    }

    public StatusBkms getStatus() {
        return status;
    }

    public void setStatus(StatusBkms status) {
        this.status = status;
    }

    
    
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

    public boolean getCondiviso() {
        return condiviso;
    }

    public void setCondiviso(boolean condiviso) {
        this.condiviso = condiviso;
    }

    public LocalDateTime getCreazione() {
        return creazione;
    }

    @JsonbTransient
    public void setCreazione(LocalDateTime creazione) {
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
