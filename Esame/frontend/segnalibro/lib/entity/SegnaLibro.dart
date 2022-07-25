class SegnaLibro {
  String? idbkm = "";
  String? descrizione = "";
  String? link = "";
  String? utente = "";
  bool? condiviso = false;
  String? creazione = "";
  String? status = "";
  String? aggiornamento = "";
  String? utenteagg = "";
  String? motivorim = "";
  String? tags = "";
  String? mail = "";
  bool? cancellato = false;
  String? version = "";
  String? error;

  SegnaLibro(
      {this.idbkm,
      this.descrizione,
      this.link,
      this.utente,
      this.condiviso,
      this.creazione,
      this.status,
      this.aggiornamento,
      this.utenteagg,
      this.motivorim,
      this.tags,
      this.mail,
      this.error});

  SegnaLibro.fromJson(Map<String, dynamic> json) {
    idbkm = json['idbkm'];
    descrizione = json['descrizione'];
    link = json['link'];
    utente = json['utente'];
    condiviso = json['condiviso'];
    creazione = json['dtcreazione'];
    status = json['status'];
    mail = json['mail'];
  }

  SegnaLibro.fromJsonPost(Map<String, dynamic> json) {
    idbkm = json['id'];
    descrizione = json['descrizione'];
    link = json['link'];
    utente = json['utente'];
    condiviso = json['condiviso'];
    creazione = json['dtcreazione'];
    status = json['status'];
    aggiornamento = json['aggiornamento'];
    utenteagg = json['utenteagg'];
    motivorim = json['motivorim'];
    tags = json['Tags'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['idbkm'] = idbkm;
    data['descrizione'] = descrizione;
    data['link'] = link;
    data['utente'] = utente;
    data['condiviso'] = condiviso;
    data['creazione'] = creazione;
    data['status'] = status;
    data['aggiornamento'] = aggiornamento;
    data['utenteagg'] = utenteagg;
    data['motivorim'] = motivorim;
    data['mail'] = mail;
    data['Tags'] = tags;

    return data;
  }
}
