import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';

import '../classes/Category.dart';
import '../classes/Items.dart';
import '../screens/root/root.dart';
import 'client.dart';

Future<http.Response> deleteItemClient(
    int id, http.Client client, Map<String, String> headers) async {
  print("i am about to cancel a selected item");
  final response = await client.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/delete'),
      headers: headers,
      body: jsonEncode(<String, String>{
        "_id": id.toString(),
      }));
  print(response.statusCode.toString() + response.body);
  return response;
}

Future<List<Category>> createCategoriesClient(
    http.Client client, Map<String, String> headers) async {
  final response = await client.get(
      Uri.parse('https://marketapp2022.azurewebsites.net/items-categories'),
      headers: headers);
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    debugPrint('200');
    List<Category> categories_list = [];
    (jsonDecode(response.body) as List).forEach((element) {
      categories_list.add(Category.fromJson(element));
    });
    categories_list.toList();

    return categories_list;
    // return parsed.map<Category>((json) => Category.fromJson(json)).toList();
    // item.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('${response.statusCode}');
    debugPrint(response.body);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create category list.');
  }
}

Future<List<Item>> createItemClient(
    http.Client client, Map<String, String> headers) async {
  print("i got in the createItem");
  final response = await client.get(
      Uri.parse('https://marketapp2022.azurewebsites.net/market-items'),
      headers: headers);

  if (response.statusCode == 200) {
    debugPrint('200');

    List<Item> items_list = [];
    (jsonDecode(response.body) as List).forEach((element) {
      items_list.add(Item.fromJson(element));
    });
    return items_list;
    // item.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('${response.statusCode}');
    print(response.body);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create item list.');
  }
}

Future<http.Response> updateItemClient(int id, Map<String, String> body,
    http.Client client, Map<String, String> headers) async {
  body["_id"] = id.toString();
  print("i am about to update a selected item of index: $id");
  final response = await client.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/update'),
      headers: headers,
      body: jsonEncode(body));
  print(response.statusCode.toString() + response.body);
  return response;
}
