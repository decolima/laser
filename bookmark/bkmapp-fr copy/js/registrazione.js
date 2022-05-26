import {doRegistration } from "../js/boundary/userstore.js"

let btnCrea = document.querySelector("#btnCrea");

btnCrea.addEventListener("click", v => {
    console.log("Event Crea Utente Click");
    registration();
})

function registration() {
    
    console.log("registration ....")
    
    let usr = document.querySelector("#rusr").value;
    let pwd = document.querySelector("#rpwd").value;
    let fname = document.querySelector("#rfirst_name").value;
    let lname = document.querySelector("#rlast_name").value;
    let roule = "User";
    let admincheck = document.querySelector("#admin");

    //console.log(admincheck.checked);
    if(admincheck.checked){
        roule = "Admin";
    }
 
    //console.log(roule);
    try {
        let response = doRegistration(usr, pwd, fname, lname, roule)
            .then(data => {
                console.log(data);
            })
     }
     catch (e) {
        console.log(e);
     }
}