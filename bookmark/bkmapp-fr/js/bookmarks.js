import { doBkms, searchBkm } from "../js/boundary/bookstore.js"

let body = document.getElementsByTagName("body")[0];
let btnCreaBkms = document.querySelector("#btnCreaBkms");

//regione di diclarazione di listener
body.addEventListener("load", loadBkms(), false);


//regione di diclarazione di listener
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
        let response = searchBkm()
            .then(bkmsdata => {
                console.log(bkmsdata);
                let table = "<table class='bkm-table'>";
                let row = "<tr class='bkm-table-head'>";
                row += "<td></td>";
                row += "<td>Id Bkm</td>";
                row += "<td>Descrizione</td>";
                row += "<td>Link</td>";
                row += "<td>Creazione</td>";
                row += "<td>Autore</td>";
                row += "<td>Condiviso</td>";
                row += "<td>Status</td>";
                row += "<td>Motivo</td>";
                row += "</tr>";

                table += row;


                for (let i = 0; i < bkmsdata.length; i++) {
                    row = "<tr class = 'bkm-table-body'>";
                    row += "<td><input type='button' value='Dettagli' class='btnDetails' name = '" 
                            + bkmsdata[i].idbkm + "/"
                            + bkmsdata[i].status + "/"
                            + bkmsdata[i].motivorim + "/"
                            + "' ></td>";
                    row += "<td>" + bkmsdata[i].idbkm + "</td>";
                    row += "<td>" + bkmsdata[i].descrizione + "</td>";
                    row += "<td>" + bkmsdata[i].link + "</td>";
                    row += "<td>" + bkmsdata[i].dtcreazione + "</td>";
                    row += "<td>" + bkmsdata[i].utente + "</td>";
                    row += "<td>" + bkmsdata[i].condiviso + "</td>";
                    row += "<td>" + bkmsdata[i].status + "</td>";
                    row += "<td>" + bkmsdata[i].motivorim + "</td>";
                    row += "</tr>";
                    table += row;
                }

                table += "</table>";

                document.querySelector("#divbkms").innerHTML = table;

            })
    } catch (e) {
        console.log(e);
    }

}

body.addEventListener( 'click', function ( event ) {
    if( event.target.className == 'btnDetails' ) {
      console.log("il button worka");
      
      let test = event.target.name;

      console.log(test);

      const myArray = test.split("/");

      console.log(myArray);
    }
})







