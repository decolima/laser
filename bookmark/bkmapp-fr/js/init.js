console.log("script iniziale Init.....");

export function init() {
    
    console.log("Script Init .....")
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
        label.style.display = "none";
    }

}

export default {init};