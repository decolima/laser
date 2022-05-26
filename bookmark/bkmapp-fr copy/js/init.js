import { logout } from "../js/service/control.js";

//regione di diclarazione di variabile per listener
let body = document.getElementsByTagName("body")[0];
let ahref_logout = document.querySelector("#login");


//regione di diclarazione di listener
body.addEventListener("load", init(), false);

ahref_logout.addEventListener("click", v => {
    console.log("Event LogOut Click");
    logout();
});

//regione di funcione generale e controllo di navbar
export function init() {
    let in_out = document.querySelector("#in_out");
    let signup = document.querySelector("#signup");
    let usr = sessionStorage.getItem("mail");
    let logged = document.querySelector("#loggeduser");
    let label = document.querySelector("#usr-a");
    let bkm = document.querySelector("#bkm");
    let divcheck = document.querySelector("#divcheck");

    if (usr) // loggato
    {
        in_out.setAttribute("href", "#");
        in_out.innerHTML = "Logout";
        logged.style.display = "block";
        label.style.display = "block";
        bkm.style.display = "block";
        document.querySelector("#usr-a").innerHTML = usr;
        let loggedroule = sessionStorage.getItem("roule");
        if (loggedroule === "Admin") {
            signup.innerHTML = "Crea User";
            if (document.URL.includes("registration.html")) {
                divcheck.style.display = "flex";
            }
        }
        if (loggedroule === "User") {
            document.querySelector(`.signup`).style.display="none";
        }

    }

    else //non loggato
    {
        in_out.setAttribute("href", "login.html");
        in_out.innerHTML = "Login";
        signin.style.display = "block";
        logged.style.display = "none";
        label.style.display = "none";
        bkm.style.display = "none";

    }

}

export default { init };