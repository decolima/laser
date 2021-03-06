class Consegna {
  int? id = 0;
  String? idamazon = "";
  double? pesopaco = 0;
  String? dimensione = "";
  String? indirizzo = "";
  String? stconsegna = "";
  String? error = "";
  bool? cancellato = false;
  int? version = 0;

  Consegna(
      {this.id,
      this.idamazon,
      this.pesopaco,
      this.dimensione,
      this.indirizzo,
      this.stconsegna,
      this.cancellato,
      this.version,
      this.error});

  Consegna.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idamazon = json['idamazon'];
    pesopaco = json['pesopaco'];
    dimensione = json['dimensione'];
    indirizzo = json['indirizzo'];
    stconsegna = json['stconsegna'];
    cancellato = json['cancellato'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idamazon'] = idamazon;
    data['pesopaco'] = pesopaco;
    data['dimensione'] = dimensione;
    data['indirizzo'] = indirizzo;
    data['stconsegna'] = stconsegna;
    return data;
  }
}
