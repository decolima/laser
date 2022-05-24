
import { doLogin } from "../js/boundary/userstore.js"
import { storeToken, removeToken } from "../js/service/tokenmanager.js";

function init() {
    //sessionStorage.setItem("mail","vuoto" )
    let usr = sessionStorage.getItem("mail");
    let login = document.querySelector("#login");
    let logout = document.querySelector("#logout");
    let logged = document.querySelector("#loggeduser");
    let signin = document.querySelector("#signin");
    let label = document.querySelector("#usr-a");
    if (usr) // loggato
    {
        login.style.display = "none";
        signin.style.display = "none";
        logout.style.display= "block";
        logged.style.display = "block";
        label.style.display = "block";
        document.querySelector("#usr-a").innerHTML = usr;
    }

    else //non loggato
    {
        login.style.display = "block";
        signin.style.display = "block";
        logout.style.display= "none";
        logged.style.display = "none";
    }
}

function logout() {
    removeToken();
    sessionStorage.clear();
    window.location.href = "login.html";

}

function login() {

   
    console.log("Script Login ...")

    let url = "http://192.168.0.125:8080/bkmapp/resources/users/login";
    let usr = document.querySelector("#lusr").value;
    let pwd = document.querySelector("#lpwd").value;
    let string = "Ciao, "
    let postdata = {
        "usr": usr,
        "pwd": pwd
    };

    postdata = JSON.stringify(postdata);
    fetch(url,
        {
            method: "post",
            body: postdata,
            headers: {
                "Accept": 'application/json',
                "Content-type": 'application/json'
            }
        })
        .then(response => {
            if (response.status == 401) {
                //alert("username errata");
            }
            else
                return response.json();
        })
        .then(jsobj => {
            if (jsobj != undefined || true) {
                storeToken(jsobj.token);
                //sessionStorage.setItem("token", jsobj.token);
                sessionStorage.setItem("mail", jsobj.mail);
                sessionStorage.setItem("id", jsobj.userid);
                sessionStorage.setItem("first_name", jsobj.first_name);
                sessionStorage.setItem("last_name", jsobj.last_name);
                document.querySelector("#loggeduser").innerHTML = sessionStorage.getItem("mail");
                init();
            }
        })
        .catch(error => {
            console.log(error);
            document.querySelector("#loggeduser").innerHTML = "";

        }

        );



}

function registration() {
    let url = "http://192.168.0.125:8080/bkmapp/resources/users";
    let usr = document.querySelector("#rusr").value;
    let pwd = document.querySelector("#rpwd").value;
    let fname = document.querySelector("#rfirst_name").value;
    let lname = document.querySelector("#rlast_name").value;
    let postdata = {
        "email": usr,
        "pwd": pwd,
        "first_name": fname,
        "last_name": lname
    };
    postdata = JSON.stringify(postdata);
    fetch(url,
        {
            method: "post",
            body: postdata,
            headers: {
                "Accept": 'application/json',
                "Content-type": 'application/json'
            }
        })
        .then(response => {
            if (response.status == 401) {
                //alert("username errata");
            }
            else
                return response.json();
        })
        .catch(error => {
            console.log(error);
        }

        );



}

