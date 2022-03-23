import 'package:http/http.dart' as http;
import 'package:market_app/http/auth.dart';
import 'dart:convert';
import '../classes/Items.dart';
import 'requests.dart';
import '../classes/Category.dart';

class ApiClient {
  Map<String, String> headers = {};
  http.Client client = http.Client();
  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['jwt'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Future<List<Category>> createCategories() async {
    return await createCategoriesClient(client, headers);
  }

  Future<List<Item>> createItem() async {
    return await createItemClient(client, headers);
  }

  Future<void> deleteItem(int id) async {
    return await deleteItemClient(id, client, headers);
  }

  // auth

  Future<http.Response> login(String username, String password) async {
    http.Response response = await loginClient(username, password, client);
    updateCookie(response);
    return response;
  }

  Future<http.Response> signup(
      String username, String email, String group, String password) async {
    http.Response res =
        await signupClient(username, email, group, password, client);
    updateCookie(res);
    return res;
  }

  Future<String> onStartUp() async {
    return await onStartUpClient(client, headers);
  }
}
