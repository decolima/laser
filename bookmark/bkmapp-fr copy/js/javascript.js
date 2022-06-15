import { doBkms, searchBkm, searchBkmById, updateBkms, deleteBkms } from "./boundary/bookstore.js"

let body = document.getElementsByTagName("body")[0];
let bkmStatus;
let bkmMotiv;
let bkmDesc = document.querySelector("#descrizione");
let bkmLink = document.querySelector("#link");
let bkmShared = document.querySelector("#condiviso");
let role = sessionStorage.getItem("role") === "Admin";
let user = sessionStorage.getItem("mail");

body.addEventListener("load", createTable(), false);

function createTable() {
  const tableBody = document.querySelector("#bodyTable");
  let dataHtml = "";
  let i = 0;
  try {
    searchBkm()
      .then(tableData => {
        for (let bkm of tableData) {
          let date = tableData[i].dtcreazione.substring(2, 10);
          let time = tableData[i].dtcreazione.substring(12, 19);
          dataHtml += `<tr id=${i}>
            <td class='${bkm.status === "Vietato" ? 'denied' : 'approved'}'><input class='btn-info' id=${bkm.idbkm} onclick='ShowMore(this.id)' type="image" src="../img/info.png" value="Dettagli">
            <div class='show off' id=${bkm.idbkm}>
            <span>Data creazione:</span> <p>${date} ${time}</p>
            <div class='additional-info'><span class='moreInfo'>Id: </span><p>${bkm.idbkm}</p></div>
            <div><span class='moreInfo'>Status:</span> <p id='status[${i}]' onclick='Editable(this)'>${bkm.status}</p></div>
            <div class='additional-info'><span class='moreInfo'>Motivo Rim:</span> <p id='motiv[${i}]' onclick='Editable(this)'>${bkm.motivorim}</p></div>
            </div>
            </td>
            <td onclick="Editable(this)">${bkm.descrizione}</td>
            <td onclick="Editable(this)">${bkm.link}</td>
            <td id='${bkm.mail}'>${bkm.utente}</td>
            <td><input class="shared-check" id=${bkm.idbkm} type="checkbox" ${bkm.condiviso ? 'checked' : 'unchecked'}>${bkm.condiviso ? 'sì' : 'no'}</td>
            <td class='btn-container'><input class='btn-update'id=${i} onclick='Update(this.id)' type="image" src="../img/edit.png" value="Edit">
            <input class='btn-delete' id=${bkm.idbkm} onclick='Delete(this)' type="image" src="../img/delete.png" value="Delete" name=${bkm.mail}>
            </td>
            </tr>`
          i++;
        }
        tableBody.innerHTML = dataHtml;
      })
  } catch (e) {
    console.log(e);
  }

}

/* inizio funzione bottoni */

export const ShowMore = (id) => {
  let details = document.querySelector(`div[id = "${id}"]`);
  let additionalInfo = document.querySelectorAll('.additional-info')
  if (id === details.id) {
    details.classList.toggle('off');
  }
  if (role) {
    for (let info of additionalInfo) {
      info.classList.add('on');
    }
  }
}

export const Update = (i) => {
  let desc = document.querySelector(`tr[id= '${i}'] td:nth-child(2)`).innerText;
  let link = document.querySelector(`tr[id= '${i}'] td:nth-child(3)`).innerText;
  let shared = document.querySelector(`tr[id= '${i}'] td:nth-child(5)`).firstChild.checked;
  let idbkm = document.querySelector(`tr[id= '${i}'] td:nth-child(5)`).firstChild.id;
  let bkmstatus = document.querySelector(`p[id= 'status[${i}]`).innerText;
  let bkmotiv = document.querySelector(`p[id= 'motiv[${i}]']`).innerText;
  try {
    searchBkmById(idbkm)
      .then(bkmsdata => {
          for (let bkm of bkmsdata) {
            bkmStatus = role ? bkmstatus : bkm.status;
            bkmMotiv = role ? bkmotiv : bkm.motivorim;
        }
      }).then(() =>
        updateBkms(
          idbkm,
          desc,
          link,
          shared,
          bkmStatus,
          bkmMotiv
        )).then(() => {
          createTable()
        });
  } catch (e) {
    console.log(e);
  }
}

export const Delete = (elem) => {
  if(elem.name != user && !role){
    console.log("questo bkm non ti appartiene")
    return
  }
  try {
    deleteBkms(elem.id)
    .then(() =>
        createTable()
      );
  }
  catch (e) {
    console.log(e);
  }
}

export const Create = () => {
  let shared = false;
  if (bkmShared.checked) {
    shared = true;
  }
  try {
    doBkms(bkmDesc.value, bkmLink.value, shared, "Nuovo", "n.d.")
      .then(() => {
        createTable();
      })
    bkmDesc.value = "";
    bkmLink.value = "";
    bkmShared.checked = false;
  } catch (e) {
    console.log(e);
  }
}


/* fine funzione bottoni */



/* inizio funzioni ricerca e ordinamento tabella */

export function searchByName() {
  let input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.querySelector(".myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}

export function sortTable(n, elem) {
  let arrow = elem.getElementsByTagName('span');
  for(let e of arrow){
    if(e.className === 'desc') {
      e.innerHTML = '&#10224;';
      e.classList.remove('desc');
      e.classList.add('asc');
    }else if(e.className === 'asc'){
      e.innerHTML = '&#10225'
      e.classList.remove('asc');
      e.classList.add('desc')
    }
  }
  arrow = '&#10224'
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.querySelector(".myTable");
  switching = true;
  dir = "asc";
  while (switching) {
    switching = false;
    rows = table.rows;
    for (i = 1; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("td")[n];
      y = rows[i + 1].getElementsByTagName("td")[n];
      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          shouldSwitch = true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
          shouldSwitch = true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount++;
    } else {
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }

}

export const Editable = (e) => {
  e.contentEditable = true;
}


/* fine funzioni ricerca e ordinamento tabella */