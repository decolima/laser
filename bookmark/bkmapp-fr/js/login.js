function init() {
    let usr = sessionStorage.getItem("mail");
    if (usr) // loggato
    {
        document.getElementById("loggeduser").innerHTML = usr;
    }

    else //non loggato
    {
        document.getElementById("loggeduser").innerHTML = " nessun utente";
    }
}
function logout() {
    sessionStorage.removeItem("globaljwt");
    sessionStorage.clear();
    let jwt = sessionStorage.getItem("globaljwt");
    window.location.href = "login.html";

}

function login() {

   
    console.log("Script Login ...")

    let url = "http://192.168.0.125:8080/bkmapp/resources/users/login";
    let usr = document.querySelector("#lusr").value;
    let pwd = document.querySelector("#lpwd").value;
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
                sessionStorage.setItem("globaljwt", jsobj.token);
                sessionStorage.setItem("mail", jsobj.mail);
                sessionStorage.setItem("id", jsobj.userid);
                sessionStorage.setItem("first_name", jsobj.first_name);
                sessionStorage.setItem("last_name", jsobj.last_name);
                document.querySelector("#loggeduser").innerHTML = sessionStorage.getItem("mail");
            }
        })
        .catch(error => {
            console.log(error);
            document.querySelector("#loggeduser").innerHTML = " nessun utente";

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

