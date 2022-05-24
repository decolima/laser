import { postJsonData, getJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/users`

const doLogin = async (usr, pwd) => {
    return postJsonData(`${url}/login`,{usr,pwd},false);
}

export { doLogin};