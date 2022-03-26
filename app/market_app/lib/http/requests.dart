import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:market_app/classes/super_market.dart';

import 'dart:convert';

import '../classes/Category.dart';
import '../classes/Items.dart';
import '../screens/markets/markets.dart';
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

Future<http.Response> addItemClient(Map<String, String> body,
    http.Client client, Map<String, String> headers) async {
  print("i am about to add an item");
  final response = await client.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/add'),
      headers: headers,
      body: jsonEncode(body));
  print(response.statusCode.toString() + response.body);
  return response;
}

Future<List<SuperMarket>> marketsClient(
    http.Client client, Map<String, String> headers) async {
  print("i am about to search for markets");
  final response = await client.get(
    Uri.parse('https://marketapp2022.azurewebsites.net/markets'),
    headers: headers,
  );
  if (response.statusCode == 200) {
    List<SuperMarket> markets_list = [];
    (jsonDecode(response.body) as List).forEach((element) {
      markets_list.add(SuperMarket.fromJson(element));
    });
    return markets_list;
  } else {
    debugPrint('${response.statusCode}');
    print(response.body);
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get markets list.');
  }
}

Future<List<Item>> shortedItemsListClient(
    String market_name, http.Client client, Map<String, String> headers) async {
  print("i am about to get the items in shorted order");
  final response = await client.get(
    Uri.parse(
        'https://marketapp2022.azurewebsites.net/items-shorted/' + market_name),
    headers: headers,
  );
  if (response.statusCode == 200) {
    List<Item> shorted_items_list = [];
    (jsonDecode(response.body) as List).forEach((element) {
      shorted_items_list.add(Item.fromJson(element[0]));
    });
    return shorted_items_list;
  } else {
    debugPrint('${response.statusCode}');
    print(response.body);
    // If the server did not return a 200 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get items list in short order.');
  }
}
