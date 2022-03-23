import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';

import '../classes/Category.dart';
import '../classes/Items.dart';
import '../screens/root/root.dart';
import 'client.dart';

Future<void> deleteItemClient(
    int id, http.Client client, Map<String, String> headers) async {
  print("i am about to cancel a selected item");
  final response = await client.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/delete'),
      headers: headers,
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

Future<List<Category>> createCategoriesClient(
    http.Client client, Map<String, String> headers) async {
  final response = await client.get(
      Uri.parse('https://marketapp2022.azurewebsites.net/get-ItemCategories'),
      headers: headers);
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

Future<List<Item>> createItemClient(
    http.Client client, Map<String, String> headers) async {
  print("i got in the createItem");
  final response = await client.get(
      Uri.parse('https://marketapp2022.azurewebsites.net/market-items'),
      headers: headers);

  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    debugPrint('200');
    print(response.body);
    return parsed.map<Item>((json) => Item.fromJson(json)).toList();
    // item.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('${response.statusCode}');
    print(response.body);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create item list.');
  }
}
