import { postJsonData, getJsonData, putJsonData, delJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/books?page=1&size=1000`
const url2 = `${configData.baseurl}/books`

const searchBkm = () => {
    return getJsonData(url, true)
}

const searchBkmById  = (id) => {
    const fullurl = `${url2}/${id}`;
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
    return await postJsonData(url,BkmData,true);
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
    return await putJsonData(url, bkmData, true);
}

const deleteBkms = async (id) =>{
    const bkmData ={
        idBook:id
    };
    return await delJsonData(url, bkmData, true);
}


export {searchBkm, doBkms, updateBkms, searchBkmById, deleteBkms };
