import { doBkms, searchBkm, searchBkmById, updateBkms, deleteBkms } from "../js/boundary/bookstore.js"
let body = document.getElementsByTagName("body")[0];
let btnCreaBkms = document.querySelector("#btnCreaBkms");
let btnNewBkms = document.querySelector("#btnNewBkms");
/* let btnDelBkm = document.querySelector(".btnDel"); */
let y = 80;
let bkmId;
let bkmStatus;
let bkmMotiv;
let bkmDesc = document.querySelector("#descrizione");
let bkmLink = document.querySelector("#link");
let bkmShared = document.querySelector("#condiviso");
/* let btnUpdateBkms = document.querySelector("#btnUpdate"); */
let role = sessionStorage.getItem("role") === "Admin";
let user = sessionStorage.getItem("mail");
console.log(role);

//regione di diclarazione di listener
body.addEventListener("load", loadBkms(), false);
/* btnUpdateBkms.addEventListener("update", updateBkms()); */


//regione di dichiarazione del listner
let CreaBkm = () => {
    let shared = false;
    if (bkmShared.checked) {
        shared = true;
    }

    try {

        doBkms(bkmDesc.value, bkmLink.value, shared, "Nuovo", "")
            .then(data => {
                console.log(data);
            })

        loadBkms();

    } catch (e) {
        console.log(e);
    }


};

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
                    row += `<td>${bkmsdata[i].descrizione}</td>`;
                    row += `<td>${bkmsdata[i].link}</td>`;
                    let date = bkmsdata[i].dtcreazione.substring(2, 10);
                    let time = bkmsdata[i].dtcreazione.substring(12, 19);
                    row += `<td> ${date} ${time}</td>`;
                    row += `<td>${bkmsdata[i].utente}</td>`;
                    row += `<td>${bkmsdata[i].condiviso}</td>`;

                    let statusbkm = bkmsdata[i].status;
                    row += "</tr> </table>";
                    if (statusbkm === "Vietato") {
                        row += `<div class= 'detail-container-denied'> <details>`;
                    } else {
                        row += `<div class= 'detail-container-approved'> <details>`;
                    }
                    row += `<div class='bkm-detail'>`;
                    row += `<p> Id: ${bkmsdata[i].idbkm}</p>`;
                    row += `<p> Status: ${bkmsdata[i].status} </p>`;
                    row += `<p> Motivo: ${bkmsdata[i].motivorim}</p>`;
                    row += `<div class='btns-conf-del'><input class='btnUpdate' id='${bkmsdata[i].idbkm}' type='button' value='Aggiorna'>`;
                    row += `<input type='button' class='btnDel' id='${bkmsdata[i].idbkm}' value='Elimina'></div>`;
                    row += `</div>`
                    row += `</details> </div>`;

                    table += row;
                }

                document.querySelector("#divbkms").innerHTML = table;

            })
    } catch (e) {
        console.log(e);
    }

}




/* 

    Definisco la funzione che caricherà i dati in base all'id del bookmark ottenuto dall'id bottone

*/

$(document).on("click", ".btnUpdate", function () {
    try {
        searchBkmById(this.id)
            .then(bkmsdata => {
                console.log(bkmsdata);

                for (let i = 0; i < bkmsdata.length; i++) {
                    if (user === bkmsdata[i].mail) {
                        bkmId = this.id;
                        bkmDesc.value = bkmsdata[i].descrizione;
                        bkmLink.value = bkmsdata[i].link;
                        bkmStatus = bkmsdata[i].status;
                        bkmMotiv = bkmsdata[i].motivorim;
                        console.log(bkmId);
                        console.log(bkmStatus);
                        console.log(bkmMotiv);

                        if (bkmsdata[i].condiviso === true) {
                            bkmShared.checked = true;
                        } if (bkmsdata[i].condiviso === false) {
                            bkmShared.checked = false;
                        }
                        document.querySelector("#btnNewBkms").disabled = false;
                        btnCreaBkms.value = "Conferma Modifiche";
                        window.scrollTo({
                            top: y,
                            behavior: "smooth",
                        });
                    } else {
                        console.log("non sei il proprietario di questo bookmark");
                    }
                }
            })
    } catch (e) {
        console.log(e);
    }
});

$(document).on("click", "#btnNewBkms", function () {
    prepareBkm();
    this.disabled = true;
});

$(document).on("click", "#btnCreaBkms", function () {
    if (this.value === "Conferma Modifiche") {
        console.log("sto aggiornando un bookmark")
        try {
            updateBkms(
                bkmId,
                bkmDesc.value,
                bkmLink.value,
                bkmShared.checked,
                bkmStatus,
                bkmMotiv
            ).then(() =>{
                loadBkms()
            });
        } catch (e){
            console.log(e);
        }
    }
    if (this.value === "Crea Bookmark") {
        console.log("sto creando un bookmark");
        CreaBkm();
    }
    prepareBkm();
    
})

const prepareBkm = () => {
    bkmDesc.value = ""
    bkmLink.value = ""
    bkmShared.checked = false;
    btnCreaBkms.value = "Crea Bookmark";
    btnNewBkms.disabled = true;
}

$(document).on("click", ".btnDel", function () {
    try{
        console.log(this.id)
        const deleted = deleteBkms(this.id);
        console.log(deleted);
        }
    catch (e){
        console.log(e);
    }
});










