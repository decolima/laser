import { doRegistration } from "./boundary/userstore.js"

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
    let role = "User";
    let admincheck = document.querySelector("#divcheck");

    //console.log(admincheck.checked);
    if (admincheck.checked) {
        role = "Admin";
    }

    //console.log(role);
    try {
        doRegistration(usr, pwd, fname, lname, role)
            .then(data => {
                console.log(data);
                window.alert("Nuovo utente creato con successo")
                document.querySelector("#rusr").value = "";
                document.querySelector("#rpwd").value = "";
                document.querySelector("#rfirst_name").value = "";
                document.querySelector("#rlast_name").value = "";
            })
    }
    catch (e) {
        console.log(e);
    }
}