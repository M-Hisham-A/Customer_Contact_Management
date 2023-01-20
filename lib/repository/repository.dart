import 'dart:convert';
import 'package:detailmanagement/main.dart';
import 'package:http/http.dart';

class UserRepository {
  String endpoint = "https://jsonplaceholder.typicode.com/users";

  Future<List<Model>> getUsers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Model.fromjson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Model> getUserDetail(int id) async {
    Response response = await get(Uri.parse(endpoint + "/" + id.toString()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return Model.fromjson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
