import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_dao.dart';
import 'package:carros/pages/favoritos/favorito.dart';
import 'package:carros/pages/favoritos/favorito_dao.dart';
import 'package:provider/provider.dart';

import 'favoritos_model.dart';

class FavoritoService {
  static Future<bool> favoritar(context, Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists) {
      dao.delete(c.id);

      Provider.of<FavoritosModel>(context, listen: false).getCarros();

      return false;
    } else {
      dao.save(f);

      Provider.of<FavoritosModel>(context, listen: false).getCarros();

      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    String sql = "select * from carro c, favorito f where c.id = f.id";

    List<Carro> carros = await CarroDAO().query(sql);

    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    return FavoritoDAO().exists(c.id);
  }
}
