import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/utils/network.dart';
import 'package:carros/utils/simple_bloc.dart';

import 'carro.dart';
import 'carro_dao.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool netWorkOn = await isnetWorkOn();

      if (!netWorkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      if (carros.isNotEmpty) {
        final dao = CarroDAO();

        carros.forEach(dao.save);
      }

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }
}
