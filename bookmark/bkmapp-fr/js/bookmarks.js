import { doBkms, searchBkm, searchBkmById } from "../js/boundary/bookstore.js"
let body = document.getElementsByTagName("body")[0];
let btnCreaBkms = document.querySelector("#btnCreaBkms");
/* let btnUpdateBkms = document.querySelector("#btnUpdate"); */
let role = sessionStorage.getItem("role") === "Admin";
console.log(role);

//regione di diclarazione di listener
body.addEventListener("load", loadBkms(), false);
/* btnUpdateBkms.addEventListener("update", updateBkms()); */


//regione di dichiarazione del listner
btnCreaBkms.addEventListener("click", v => {
    console.log("Event creaBkms Click");
    v.preventDefault;
    let txtDesc = document.getElementById("descrizione").value;
    let txtLink = document.getElementById("link").value;
    let ckCondiviso = document.getElementById("condiviso");
    let shared = false;

    if (ckCondiviso.checked) {
        shared = true;
    }

    try {

        let response = doBkms(txtDesc, txtLink, shared, "Nuovo", "")
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
        searchBkm()
            .then(bkmsdata => {
                console.log(bkmsdata);
                let table = "<table class='bkm-table'>";
                let row = "<tr class='bkm-table-head'>";
                row += "<td>Descrizione</td>";
                row += "<td>Link</td>";
                row += "<td>Creazione</td>";
                row += "<td>Autore</td>";
                row += "<td>Condiviso</td>";
                row += "</tr>";

                table += row;


                for (let i = 0; i < bkmsdata.length; i++) {
                    row = "<table class='bkm-table' id=table><tr class = 'bkm-table-body'>";
                    row += "<td id= tdesc/"+i+">" + bkmsdata[i].descrizione + "</td>";
                    row += "<td id= tlink/"+i+">" + bkmsdata[i].link + "</td>";
                    let date = bkmsdata[i].dtcreazione.substring(2, 10);
                    let time = bkmsdata[i].dtcreazione.substring(12, 19);
                    row += "<td>" + date + " " + time + "</td>";
                    row += "<td>" + bkmsdata[i].utente + "</td>";
                    row += "<td>" + bkmsdata[i].condiviso + "</td>";

                    let statusbkm = bkmsdata[i].status;
                    row += "</tr> </table>";
                    if(statusbkm === "Vietato"){
                    row += "<div class= 'detail-container-denied'> <details>";
                    }else{
                        row += "<div class= 'detail-container-approved'> <details>";
                    }
                    row += "<div class='bkm-detail'>";
                    row += "<p> Id: " + bkmsdata[i].idbkm + "</p>";
                    row += "<p> Status: " + bkmsdata[i].status + "</p>";
                    row += "<p> Motivo: " + bkmsdata[i].motivorim + "</p>";
                    row += `<div class='btns-conf-del'><input class='btnUpdate' id='${bkmsdata[i].idbkm}' type='button' value='Aggiorna'>`;
                    row += `<input type='button' id='${i}' value='Elimina'></div>`;
                    row += "</div>"
                    row += "</details> </div>";

                    table += row;
                }

                document.querySelector("#divbkms").innerHTML = table;

            })
    } catch (e) {
        console.log(e);
    }

}

/* let btns = document.querySelectorAll(".btnUpdate");
for (let i = 0; i < btns.length; i++) {
    btns[i].addEventListener("click", function () {
        console.log("prova")
    });
} */

$(document).on("click", ".btnUpdate", function(){
    try {
        let bkm = searchBkmById(this.id)
            .then(bkmsdata => {
                console.log(bkmsdata);

                for (let i = 0; i < bkmsdata.length; i++) {
                        
                    document.getElementById("descrizione").innerText = bkm.descrizione;
                    document.getElementById("link").innerText = bkm.link; 
                    document.getElementById("condiviso").value = bkm.condiviso; 
    
        /*
                    row = "<table class='bkm-table' id=table><tr class = 'bkm-table-body'>";
                    row += "<td id= tdesc/"+i+">" + bkmsdata[i].descrizione + "</td>";
                    row += "<td id= tlink/"+i+">" + bkmsdata[i].link + "</td>";
                    let date = bkmsdata[i].dtcreazione.substring(2, 10);
                    let time = bkmsdata[i].dtcreazione.substring(12, 19);
                    row += "<td>" + date + " " + time + "</td>";
                    row += "<td>" + bkmsdata[i].utente + "</td>";
                    row += "<td>" + bkmsdata[i].condiviso + "</td>";

                    let statusbkm = bkmsdata[i].status;
                    row += "</tr> </table>";
                    if(statusbkm === "Vietato"){
                    row += "<div class= 'detail-container-denied'> <details>";
                    }else{
                        row += "<div class= 'detail-container-approved'> <details>";
                    }
                    row += "<div class='bkm-detail'>";
                    row += "<p> Id: " + bkmsdata[i].idbkm + "</p>";
                    row += "<p> Status: " + bkmsdata[i].status + "</p>";
                    row += "<p> Motivo: " + bkmsdata[i].motivorim + "</p>";
                    row += `<div class='btns-conf-del'><input class='btnUpdate' id='${bkmsdata[i].idbkm}' type='button' value='Aggiorna'>`;
                    row += `<input type='button' id='${i}' value='Elimina'></div>`;
                    row += "</div>"
                    row += "</details> </div>";

                    table += row;
                }

                document.querySelector("#divbkms").innerHTML = table;
        */

            })
    } catch (e) {
        console.log(e);
    }


    
});










