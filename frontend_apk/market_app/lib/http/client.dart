import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:market_app/classes/super_market.dart';
import 'package:market_app/http/auth.dart';
import 'dart:convert';
import '../classes/Items.dart';
import '../classes/user.dart';
import 'requests.dart';
import '../classes/Category.dart';

final storage = FlutterSecureStorage();

class ApiClient {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  http.Client client = http.Client();

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      int start = rawCookie.indexOf('=') + 1;
      headers['jwt'] = (index == -1)
          ? rawCookie.substring(start)
          : rawCookie.substring(start, index);
    }
  }

  Future<List<Category>> createCategories() async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await createCategoriesClient(client, headers);
  }

  Future<List<Item>> createItem() async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await createItemClient(client, headers);
  }

  Future<http.Response> deleteItem(int id) async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await deleteItemClient(id, client, headers);
  }

  // auth

  Future<http.Response> login(String username, String password) async {
    http.Response response = await loginClient(username, password, client);
    if (response.statusCode == 200) {
      updateCookie(response);
      print("cookie jwt updated with value: " + headers["jwt"]!);
      await storage.write(key: "jwt", value: headers["jwt"]);
      User currentUser = User.fromJson(jsonDecode(response.body));
      await storage.write(key: "username", value: currentUser.username);
      await storage.write(key: "email", value: currentUser.email);
      await storage.write(key: "group", value: currentUser.group);
    }
    return response;
  }

  Future<http.Response> signup(
      String username, String email, String group, String password) async {
    http.Response response =
        await signupClient(username, email, group, password, client);
    updateCookie(response);
    if (response.statusCode == 200) {
      updateCookie(response);
      print("cookie jwt updated with value: " + headers["jwt"]!);
      await storage.write(key: "jwt", value: headers["jwt"]);
      User currentUser = User.fromJson(jsonDecode(response.body));
      await storage.write(key: "username", value: currentUser.username);
      await storage.write(key: "email", value: currentUser.email);
      await storage.write(key: "group", value: currentUser.group);
    }
    return response;
  }

  Future<String> onStartUp() async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await onStartUpClient(client, headers);
  }

  Future<http.Response> updateItem(int id, Map<String, String> body) async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await updateItemClient(id, body, client, headers);
  }

  Future<bool> logout() async {
    // var response = await logoutClient(client);
    if (true) {
      headers["jwt"] = "";
      var jwt = await storage.write(key: "jwt", value: "");
    }
    return true;
  }

  Future<http.Response> addItem(Map<String, String> body) async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await addItemClient(body, client, headers);
  }

  Future<List<SuperMarket>> markets() async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await marketsClient(client, headers);
  }

  Future<List<Item>> shortedItemsList(String market_name) async {
    var jwt = await storage.read(key: "jwt");
    headers["jwt"] = jwt.toString();
    return await shortedItemsListClient(market_name, client, headers);
  }
}
