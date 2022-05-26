import { postJsonData, getJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/books`

const searchBkm = () => {
    return getJsonData(url, true)
}

const doBkms = async (desc, link, shared) => {
    //console.log("doRegistration ....");
    const BkmData = {
        descrizione:desc,
        link:link,
        condiviso:shared
    };
    return postJsonData(url,BkmData,true);
}

export {searchBkm, doBkms };