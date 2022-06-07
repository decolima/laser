import { postJsonData, getJsonData, putJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/books`

const searchBkm = () => {
    return getJsonData(url, true)
}

const doBkms = async (desc, link, shared, status, motivorim) => {
    //console.log("doRegistration ....");
    const BkmData = {
        descrizione:desc,
        link:link,
        condiviso:shared,
        status:status,
        motivorim:motivorim
    };
    return postJsonData(url,BkmData,true);
}

const putBkms = async (id, desc, link, shared, status, motivorim) => {
    //console.log("doRegistration ....");
    
    const BkmData = {
        id:id,
        descrizione:desc,
        link:link,
        condiviso:shared,
        status:status,
        motivorim:motivorim
    };
    return putJsonData(url,BkmData,true);
}

export {searchBkm, doBkms, putBkms};