import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'api_response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'login/usuario.dart';

class UploadApi {
  static Future<ApiResponse<String>> upload(File file) async {
    try {
      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      String url = "https://carros-springboot.herokuapp.com/api/v2/upload";

      List<int> imageBytes = file.readAsBytesSync();

      String base64Image = convert.base64Encode(imageBytes);

      String fileName = path.basename(file.path);

      var params = {
        "fileName": fileName,
        "mimeType": "image/jpeg",
        "base64": base64Image
      };

      String json = convert.jsonEncode(params);

      final response =
          await http.post(url, body: json, headers: headers).timeout(
                Duration(seconds: 120),
                onTimeout: _onTimeOut,
              );

      Map<String, dynamic> map = convert.json.decode(response.body);

      String urlFoto = map["url"];
      
      return ApiResponse.ok(urlFoto);
      
    } catch (e) {
      return ApiResponse.error("Não foi possivel fazer o upload");
    }
  }

  static FutureOr<http.Response> _onTimeOut() {
    throw SocketException("Não foi possivel se comunicar com o servidor");
  }
}
