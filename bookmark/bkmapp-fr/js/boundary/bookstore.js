import { postJsonData, getJsonData, putJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/books`

const searchBkm = () => {
    return getJsonData(url, true)
}

const searchBkmById  = (id) => {
    const fullurl = `${url}/${id}`;
    console.log(fullurl);
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

const updateBkms = async (desc, link, shared) =>{
    const bkmData ={
        descrizione:desc,
        link:link,
        condiviso:shared
    };
    return putJsonData(url, bkmData, true);
}


export {searchBkm, doBkms, updateBkms, searchBkmById };
