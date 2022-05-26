import {doBkms} from "../js/boundary/bookstore.js" 

let btnCreaBkms = document.querySelector("#btnCreaBkms");

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
        
    } catch (e) {
        console.log(e);
    }


});
