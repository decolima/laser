export function init() {
    
    let usr = sessionStorage.getItem("mail");
    let login = document.querySelector("#login");
    let logout = document.querySelector("#logout");
    let logged = document.querySelector("#loggeduser");
    let signin = document.querySelector("#signin");
    let label = document.querySelector("#usr-a");
    let creausr= document.querySelector("#creausr");
    let divcheck = document.querySelector("#divcheck");
    if (usr) // loggato
    {
        login.style.display = "none";
        signin.style.display = "none";
        logout.style.display= "block";
        logged.style.display = "block";
        label.style.display = "block";
        document.querySelector("#usr-a").innerHTML = usr;
        let loggedroule = sessionStorage.getItem("roule");
        if(loggedroule === "Admin"){
            creausr.style.display = "block";
            if(document.URL.includes("registration2.html")){
                divcheck.style.display = "flex";
            }
        }
        else{
            console.log("logado user");
        }

    }

    else //non loggato
    {
        login.style.display = "block";
        signin.style.display = "block";
        logout.style.display= "none";
        logged.style.display = "none";
        label.style.display = "none";

        console.log("nao logado");

       
    }

}

export default {init};