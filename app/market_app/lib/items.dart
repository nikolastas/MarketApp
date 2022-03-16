import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class item {
  final String name;
  final int quantity;
  final String category;
  final int id;
  const item({required this.id,  required this.name, required this.category, required this.quantity});
  factory item.fromJson(Map<String, dynamic> json) {
    return item(
      id: json['_id'],
      name: json['item_name'],
      category: json['category'],
      quantity: json['quantity']
    );
  }
}
Future<List<item>> createItem(http.Client client) async {
  print("i got in the createItem");
  final response = await client
  .get(
    Uri.parse('http://localhost:3000/get-MarketItems'));

  if (response.statusCode == 200){
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    print(200);
    return parsed.map<item>((json) => item.fromJson(json)).toList();
    // item.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }

}

class items extends StatefulWidget {
  const items({ Key? key }) : super(key: key);

  @override
  State<items> createState() {
    
     return _itemsState();}
}

class _itemsState extends State<items> {
  final TextEditingController _controller = TextEditingController();
  Future<List<item>>? _futureItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (_futureItem == null) ? buildColumn() : buildFutureBuilder()
    );
  }
  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              print("trying to createitem list");
              _futureItem = createItem(http.Client());
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<List<item>> buildFutureBuilder() {
    return FutureBuilder<List<item>>(
      future: _futureItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("snapshot has Data");
          return Text('${snapshot.data?.length}');
        } else if (snapshot.hasError) {
          print(snapshot.data);
          print("snapshot doesnt has Data");
          print(snapshot.stackTrace);
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }


}

