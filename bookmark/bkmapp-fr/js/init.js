import { logout } from "../js/service/control.js";

//regione di diclarazione di variabile per listener 
const body = document.getElementsByTagName("body")[0];
const ahref_logout = document.querySelector("#logout");
let url = window.location.pathname;
let page = url.substring(url.lastIndexOf("/")+1);

//regione di diclarazione di listener
body.addEventListener("load", init(), false);

ahref_logout.addEventListener("click", () => {
    logout();
});

//regione di funcione generale e controllo di navbar
export function init() {/* 
    if(page == "login.html") return; */
    const usr = sessionStorage.getItem("mail");
    const role = sessionStorage.getItem("role") === "Admin";
    const login = document.querySelector("#login");
    const signin = document.querySelector("#signin");
    const logout = document.querySelector("#logout");
    const logged = document.querySelector("#loggeduser");
    const label = document.querySelector("#usr-a");
    const bkm = document.querySelector("#bkm");
    const creausr = document.querySelector("#creausr");
    const admincheck = document.querySelector("#admin-check");

    if (usr) // loggato
    {
        login.classList.add("off");
        signin.classList.add("off");
        logout.classList.remove("off");
        logged.classList.remove("off");
        bkm.classList.remove("off")
        label.classList.remove("off");
        label.innerHTML = usr;
        if (role) {
            creausr.classList.remove("off");
            if (document.URL.includes("registration.html")) {
                admincheck.classList.remove("off");
            }
        }
    }if (document.URL.includes("user.html")){
        const name = sessionStorage.getItem("first_name");
        const lastname = sessionStorage.getItem("last_name");
        const rolename = sessionStorage.getItem("role");
        document.querySelector("#name").innerHTML = name;
        document.querySelector("#surname").innerHTML = lastname;
        document.querySelector("#email").innerHTML = usr;
        document.querySelector("#role").innerHTML = rolename;
     }
}

export default { init };