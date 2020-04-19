import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';

import 'package:http/http.dart' as http;

import '../upload_api.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro c, File file) async {
    try {
      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      if (file != null) {
        final response = await UploadApi.upload(file);

        if (response.ok) {
          String urlFoto = response.result;
          c.urlFoto = urlFoto;
        }
      }

      var url = "https://carros-springboot.herokuapp.com/api/v2/carros";

      if (c.id != null) {
        url += "/${c.id}";
      }

      print("POST >>> $url");

      String json = c.toJson();

      var response = await (c.id == null
          ? http.post(url, body: json, headers: headers)
          : http.put(url, body: json, headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possivel salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (e) {
      print(e);

      return ApiResponse.error("Não foi possivel salvar o carro");
    }
  }

  static delete(Carro c) async {
    try {
      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = "https://carros-springboot.herokuapp.com/api/v2/carros/${c.id}";

      print("Delete >>> $url");

      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error("Não foi possivel deletar o carro");
    } catch (e) {
      print(e);

      return ApiResponse.error("Não foi possivel deletar o carro");
    }
  }
}
