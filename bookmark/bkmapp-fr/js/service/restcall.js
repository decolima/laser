import RestException from "./exceptioncall.js";
import { readToken } from "./tokenmanager.js";

const postJsonData = async (url, data, reqAuth = true) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    if (reqAuth === true) {
        headers.append('Authorization', `Bearer ${readToken()}`);
    }
    const resp = await fetch(url, {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached,
        headers: headers,
        body: JSON.stringify(data)
    }).catch(error => {
        throw new RestException(undefined,error);
    })
    if (!resp.ok) {
        throw new RestException(resp,undefined);
    }   

    return resp.json();
}

const getJsonData = async (url, reqAuth = true) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    if (reqAuth === true) {
        headers.append('Authorization', `Bearer ${readToken()}`);
    }
    const resp = await fetch(url, {
        method: 'GET', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached,
        headers: headers
    }).catch(error => {
        throw new RestException(undefined,error);
    })
    if (!resp.ok) {
        throw new RestException(resp,undefined);
    }
    return resp.json();
}


const putJsonData = async (url, reqAuth = true) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    if (reqAuth === true) {
        headers.append('Authorization', `Bearer ${readToken()}`);
    }
    const resp = await fetch(url, {
        method: 'PUT', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached,
        headers: headers
    }).catch(error => {
        throw new RestException(undefined,error);
    })
    if (!resp.ok) {
        throw new RestException(resp,undefined);
    }
    return resp.json();
}

const delJsonData = async (url, reqAuth = true) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    if (reqAuth === true) {
        headers.append('Authorization', `Bearer ${readToken()}`);
    }
    const resp = await fetch(url, {
        method: 'DELETE', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached,
        headers: headers
    }).catch(error => {
        throw new RestException(undefined,error);
    })
    if (!resp.ok) {
        throw new RestException(resp,undefined);
    }
    return resp.json();
}

const patchJsonData = async (url, reqAuth = true) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    if (reqAuth === true) {
        headers.append('Authorization', `Bearer ${readToken()}`);
    }
    const resp = await fetch(url, {
        method: 'PATCH', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached,
        headers: headers
    }).catch(error => {
        throw new RestException(undefined,error);
    })
    if (!resp.ok) {
        throw new RestException(resp,undefined);
    }
    return resp.json();
}


export { postJsonData, getJsonData, putJsonData, delJsonData, patchJsonData };