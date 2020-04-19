import 'package:carros/pages/carro/carro.dart';

import 'file:///C:/Users/Adriano/AndroidStudioProjects/carros/lib/utils/sql/entity.dart';

class Favorito extends Entity {
  int id;
  String nome;

  Favorito.fromCarro(Carro c){
    id = c.id;
    nome = c.nome;
  }

  Favorito.fromMap(Map<String, dynamic> favorito)
      : id = favorito['id'],
        nome = favorito['nome'];

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
