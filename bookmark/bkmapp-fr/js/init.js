import {logout} from "../js/service/control.js";

//regione di diclarazione di variabile per listener
let body = document.getElementsByTagName("body")[0];
let ahref_logout = document.querySelector("#logout");


//regione di diclarazione di listener
body.addEventListener("load", init(), false);

ahref_logout.addEventListener("click", v => {
    console.log("Event LogOut Click");
    logout();
});

//regione di funcione generale e controllo di navbar
export function init() {
    
    let usr = sessionStorage.getItem("mail");
    let login = document.querySelector("#login");
    let logout = document.querySelector("#logout");
    let logged = document.querySelector("#loggeduser");
    let signin = document.querySelector("#signin");
    let label = document.querySelector("#usr-a");
    let creausr= document.querySelector("#creausr");
    let bkm= document.querySelector("#bkm");
    let divcheck = document.querySelector("#divcheck");

    if (usr) // loggato
    {
        login.style.display = "none";
        signin.style.display = "none";
        logout.style.display= "block";
        logged.style.display = "block";
        label.style.display = "block";
        bkm.style.display= "block";
        document.querySelector("#usr-a").innerHTML = usr;
        let loggedroule = sessionStorage.getItem("roule");
        if(loggedroule === "Admin"){
            creausr.style.display = "block";
            if(document.URL.includes("registration.html")){
                divcheck.style.display = "flex";
            }
        }

    }

    else //non loggato
    {
        login.style.display = "block";
        signin.style.display = "block";
        logout.style.display= "none";
        logged.style.display = "none";
        label.style.display = "none";
        bkm.style.display= "none";
  
    }

}

export default {init};