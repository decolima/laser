import {doRegistration } from "../js/boundary/userstore.js"
import {init} from "./init.js" 

let ahref_logout = document.querySelector("#logout");
let btnCrea = document.querySelector("#btnCrea");
/* let body = document.getElementsByTagName("body")[0];

body.addEventListener("load", init(), false); */

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

    console.log(admincheck.checked);
    if(admincheck.checked){
        roule = "Admin";
    }
    else{
        roule = "User";
    }
    console.log(roule);
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

ahref_logout.addEventListener("click", v => {
    console.log("Event LogOut Click");
    logout();
});


function logout() {
    sessionStorage.removeItem("token");
    sessionStorage.clear();
    window.location.href = "login.html";

};
