import { postJsonData, getJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/users`

const doLogin = async (usr, pwd) => {

    console.log("doLogin ....");

    return postJsonData(`${url}/login`,{usr,pwd},false);
}

const doRegistration = async (usr, pwd, fname, lname, ruole) => {

    console.log("doRegistration ....");

    const UserData = {
        first_name:fname,
        last_name:lname,
        email:usr,
        pwd:pwd,
        roleuser:ruole
    };
    

    return postJsonData(url,UserData,false);
}


export {doLogin, doRegistration};