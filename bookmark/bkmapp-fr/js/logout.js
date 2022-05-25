let ahref_logout = document.querySelector("#logout");

ahref_logout.addEventListener("click", v => {
    console.log("Event LogOut Click");
    logout();
});


export function logout() {
    sessionStorage.removeItem("token");
    sessionStorage.clear();
    window.location.href = "login.html";
    console.log("prova logout")
};

export default {logout};