import 'dart:ffi';

class Bkms {
  Long idbkm = 0 as Long;
  String descrizione = "";
  String link = "";
  String utente = "";
  bool condiviso = false;
  String dtcreazione = "";
  String status = "";
  String dtaggiornamento = "";
  String utenteagg = "";
  String motivorim = "";
  String? tags = "";
  String? error;

  Bkms(
      {required this.idbkm,
      required this.descrizione,
      required this.link,
      required this.utente,
      required this.condiviso,
      required this.dtcreazione,
      required this.status,
      required this.dtaggiornamento,
      required this.utenteagg,
      required this.motivorim,
      required this.tags,
      required this.error});

  Bkms.fromJson(Map<String, dynamic> json) {
    idbkm = json['idbkm'];
    descrizione = json['descrizione'];
    link = json['link'];
    utente = json['utente'];
    condiviso = json['condiviso'];
    dtcreazione = json['dtcreazione'];
    status = json['status'];
    dtaggiornamento = json['dtaggiornamento'];
    utenteagg = json['utenteagg'];
    motivorim = json['motivorim'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['idbkm'] = idbkm;
    data['descrizione'] = descrizione;
    data['link'] = link;
    data['utente'] = utente;
    data['condiviso'] = condiviso;
    data['dtcreazione'] = dtcreazione;
    data['status'] = status;
    data['dtaggiornamento'] = dtaggiornamento;
    data['utenteagg'] = utenteagg;
    data['motivorim'] = motivorim;
    data['tags'] = tags;

    return data;
  }
}
