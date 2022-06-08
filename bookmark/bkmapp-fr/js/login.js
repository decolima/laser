import { doLogin } from "../js/boundary/userstore.js"
import { init } from "../js/init.js"


let btnLogin = document.querySelector("#btnLogin");

btnLogin.addEventListener("click", v => {
    login();
});


function login() {

    let usr = document.querySelector("#lusr").value;
    let pwd = document.querySelector("#lpwd").value;

    try {
        let response = doLogin(usr,pwd)
            .then(data => {
                //console.log(data);
                sessionStorage.setItem("token",data.token);
                sessionStorage.setItem("mail", data.mail);
                sessionStorage.setItem("id", data.userid);
                sessionStorage.setItem("first_name", data.first_name);
                sessionStorage.setItem("last_name", data.last_name);
                sessionStorage.setItem("role", data.role);
                window.location.replace("bookmarks.html");
                init();
            })
     }
     catch (e) {
        console.log(e);
     }
};


