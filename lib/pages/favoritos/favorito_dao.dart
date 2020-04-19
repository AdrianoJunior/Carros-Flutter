import 'file:///C:/Users/Adriano/AndroidStudioProjects/carros/lib/utils/sql/base_dao.dart';

import 'favorito.dart';

class FavoritoDAO extends BaseDAO<Favorito>{
  @override
  fromJson(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";

}