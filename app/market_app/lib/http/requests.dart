import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../classes/Category.dart';
import '../classes/Items.dart';

Future<void> deleteItem(int id) async {
  print("i am about to cancel a selected item");
  final response = await http.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": id.toString(),
        "collection_name": 'MarketItems'
      }));
  if (response.statusCode == 200) {
    print("deleted successfully");
    return;
  } else {
    print("something went wrong");
    return;
  }
}

Future<List<Category>> createCategories(http.Client client) async {
  final response = await client.get(
      Uri.parse('https://marketapp2022.azurewebsites.net/get-ItemCategories'));
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    debugPrint('200');
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
    // item.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('${response.statusCode}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create category list.');
  }
}

Future<List<Item>> createItem(http.Client client) async {
  print("i got in the createItem");
  final response = await client.get(
      Uri.parse('https://marketapp2022.azurewebsites.net/get-MarketItems'));

  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    debugPrint('200');
    return parsed.map<Item>((json) => Item.fromJson(json)).toList();
    // item.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('${response.statusCode}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create item list.');
  }
}
