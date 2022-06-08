import { postJsonData, getJsonData, putJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/books`

const searchBkm = () => {
    return getJsonData(url, true)
}

const searchBkmById  = (id) => {
    const fullurl = `${url}/${id}`;
    return getJsonData(fullurl, true)
}

const doBkms = async (desc, link, shared, status, motivorim) => {
    const BkmData = {
        descrizione:desc,
        link:link,
        condiviso:shared,
        status:status,
        motivorim:motivorim
    };
    return postJsonData(url,BkmData,true);
}

const updateBkms = async (id, desc, link, shared, status, motivorim) =>{
    const bkmData ={
        id:id,
        descrizione:desc,
        link:link,
        condiviso:shared,
        status:status,
        motivorim:motivorim
    };
    return putJsonData(url, bkmData, true);
}


export {searchBkm, doBkms, updateBkms, searchBkmById };
