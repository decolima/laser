import {doBkms, searchBkm} from "../js/boundary/bookstore.js" 

let body = document.getElementsByTagName("body")[0];
let btnCreaBkms = document.querySelector("#btnCreaBkms");

//regione di diclarazione di listener
body.addEventListener("load", loadBkms(), false);


//regione di diclarazione di listener
btnCreaBkms.addEventListener("click", v => {
    console.log("Event creaBkms Click");

    let txtDesc = document.getElementById("descrizione");
    let txtLink = document.getElementById("link");
    let ckCondiviso = document.getElementById("condiviso");
    let shared = 0;

    if(ckCondiviso.checked){
        shared = 1;
    }

    try {
     
        let response = doBkms(txtDesc.value, txtLink.value, shared)
                        .then(data => {
                                console.log(data);
                        })

        loadBkms();
        
    } catch (e) {
        console.log(e);
    }


});

function loadBkms() {

    try {
        let response = searchBkm()
                        .then(bkmsdata => {
                            console.log(bkmsdata);
                            let table = "<table>";
                           
                            let row = "<tr>";
                                row += "<td>IdBookMk</td>";
                                row += "<td>Descrizione</td>"; 
                                row += "<td>Link</td>"; 
                                row += "<td>DtCreazione</td>";  
                                row += "<td>Autore</td>";  
                                row += "<td>Condiviso</td>";  
                                row +="</tr>";
                           
                            table += row;
                           
                            for (let i = 0; i < bkmsdata.length; i++) {
                                row = "<tr>";
                                row += "<td>" + bkmsdata[i].IdBookMk + "</td>";
                                row += "<td>" + bkmsdata[i].descrizione + "</td>"; 
                                row += "<td>" + bkmsdata[i].link + "</td>"; 
                                row += "<td>" + bkmsdata[i].DtCreazione + "</td>";  
                                row += "<td>" + bkmsdata[i].Utente + "</td>";  
                                row += "<td>" + bkmsdata[i].condiviso + "</td>";  
                                row +="</tr>";
                        
                                table += row;
                            }
                            
                            table += "</table>";
                
                            document.querySelector("#divbkms").innerHTML = table;

                        })
    } catch (e) {
        console.log(e);
    }

}