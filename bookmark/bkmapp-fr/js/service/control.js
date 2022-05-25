

export function logout() {

    console.log("Module Control ... logout()")

    sessionStorage.removeItem("token");
    sessionStorage.clear();
    window.location.href = "login.html";
    
};



export default {logout};