import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'client.dart';
import 'package:market_app/http/client.dart';
import 'client.dart';

String baseURL = "https://marketapp2022.azurewebsites.net";
Future<http.Response> loginClient(
    String username, String password, http.Client client) async {
  print("i am about to login with credentials: " + username + " " + password);
  var response = await http.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}));
  print(response.body);

  return response;
}

Future<http.Response> signupClient(String username, String email, String group,
    String password, http.Client client) async {
  print("i am about to signup");
  final response = await client.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
        "group": group,
        "email": email
      }));

  return response;
}

Future<String> onStartUpClient(
    http.Client client, Map<String, String> headers) async {
  String retVal = "error";

  try {
    final response = await client.get(
        Uri.parse('https://marketapp2022.azurewebsites.net/checkUser'),
        headers: headers);
    if (response.statusCode == 200) {
      print("repsonce: " + response.body);
      retVal = "ok";
    } else {
      print("got on start up but error happend");
      print(response.body);
    }
  } catch (e) {
    print("error on onStrartUp" + e.toString());
  }
  return retVal;
}

Future<http.Response> logoutClient(http.Client client) async {
  print("i am about to logout with credentials");
  var response = await http.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}));
  print(response.body);

  return response;
}
