import 'dart:convert' as convert;

import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/sql/entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CarroEvent extends Event {

  String acao;

  String tipo;

  CarroEvent(this.acao, this.tipo);

  @override
  String toString() {
    return 'CarroEvent{acao: $acao, tipo: $tipo}';
  }


}

class Carro extends Entity {
  int id;
  String tipo;
  String nome;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  latlng() {
    return LatLng(latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
        longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude));
  }

  Carro({
    this.id,
    this.tipo,
    this.nome,
    this.descricao,
    this.urlFoto,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  Carro.fromMap(Map<String, dynamic> carro)
      : id = carro['id'],
        tipo = carro['tipo'],
        nome = carro['nome'],
        descricao = carro['descricao'],
        urlFoto = carro['urlFoto'],
        urlVideo = carro['urlVideo'],
        latitude = carro['latitude'],
        longitude = carro['longitude'];

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

}
