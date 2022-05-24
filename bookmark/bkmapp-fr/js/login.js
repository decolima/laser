import { doLogin } from "../js/boundary/userstore.js"
import {init} from "./init.js" 

let btnLogin = document.querySelector("#btnLogin");
let ahref_logout = document.querySelector("#logout");
let body = document.getElementsByTagName("body")[0];

body.addEventListener("load", init(), false);

btnLogin.addEventListener("click", v => {
    console.log("Event Login Click");
    login();
});

ahref_logout.addEventListener("click", v => {
    console.log("Event LogOut Click");
    logout();
});


function logout() {
    sessionStorage.removeItem("token");
    sessionStorage.clear();
    window.location.href = "login.html";

};


function login() {

    console.log("Login ...")

    let usr = document.querySelector("#lusr").value;
    let pwd = document.querySelector("#lpwd").value;

    try {
        let response = doLogin(usr,pwd)
            .then(data => {
                console.log(data);
                sessionStorage.setItem("token",data.token);
                sessionStorage.setItem("mail", data.mail);
                sessionStorage.setItem("id", data.userid);
                sessionStorage.setItem("first_name", data.first_name);
                sessionStorage.setItem("last_name", data.last_name);
                sessionStorage.setItem("roule", data.roule);
                init();
            })
     }
     catch (e) {
        console.log(e);
     }
};


