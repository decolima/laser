function change(){
    let in_out = document.querySelector("#in_out");
    if(in_out.getAttribute("href") === "login.html"){
        in_out.setAttribute("href", "#");
        in_out.innerHTML = "Logout";
    }else{
        in_out.setAttribute("href", "login.html");
        in_out.innerHTML = "Login";
    }
}
