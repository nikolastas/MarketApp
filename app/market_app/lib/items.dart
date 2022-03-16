import 'dart:convert';

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
    Uri.parse('https://marketapp2022.azurewebsites.net/get-MarketItems'));

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
    return Scaffold(
      body: buildFutureBuilder()
    
    );  }
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
      future: createItem(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("snapshot has Data");
          return  ItemsList(items:snapshot.data!);
          
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

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key, required this.items}) : super(key: key);

  final List<item> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20, 
        crossAxisCount: 2
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('${items[index].quantity}'),
                      SizedBox(width: 10,),
                      Text(items[index].name),
                      ]),
                      SizedBox(height: 10,),
                      Text(items[index].category)
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
              );
      },
    );
  }
}