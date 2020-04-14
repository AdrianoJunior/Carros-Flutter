class Carro {
  int id;
  String tipo;
  String nome;
  String desc;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Carro({
    this.id,
    this.tipo,
    this.nome,
    this.desc,
    this.urlFoto,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  Carro.fromJson(Map<String, dynamic> carro) :
    id = carro['id'],
    tipo = carro['tipo'],
    nome = carro['nome'],
    desc = carro['desc'],
    urlFoto = carro['urlFoto'],
    urlVideo = carro['urlVideo'],
    latitude = carro['latitude'],
    longitude = carro['longitude'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['desc'] = this.desc;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
