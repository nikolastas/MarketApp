import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> login(String username, String password) async {
  print("i am about to login");
  final response = await http.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}));
  print(response.body);
  return response;
}
