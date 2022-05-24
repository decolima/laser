import { postJsonData, getJsonData } from "../service/restcall.js";
import configData from "../service/config.js";

const url = `${configData.baseurl}/books`

const searchBkm = () => {
    return getJsonData(url)
}

export {searchBkm };