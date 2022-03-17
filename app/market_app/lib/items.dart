import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Item {
  final String name;
  final int quantity;
  final String category;
  final int id;
  bool value;
  Item(
      {required this.id,
      required this.name,
      required this.category,
      required this.quantity,
      required this.value});
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['_id'],
        name: json['item_name'],
        category: json['category'],
        quantity: json['quantity'],
        value: false);
  }
}

Future<void> deleteItem(http.Client client, int id) async {
  print("i am about to cancel a selected item");
  final response = await client
      .post(Uri.parse('https://marketapp2022.azurewebsites.net/delete'), body: {
    jsonEncode(<String, String>{"id": '$id', "collection_name": 'MarketItems'})
  });
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
    throw Exception('Failed to create album.');
  }
}

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() {
    return ItemsState();
  }
}

class ItemsState extends State<Items> {
  final TextEditingController _controller = TextEditingController();
  Future<List<Item>>? _futureItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildFutureBuilder());
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
              debugPrint("trying to createitem list");
              _futureItem = createItem(http.Client());
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<List<Item>> buildFutureBuilder() {
    return FutureBuilder<List<Item>>(
      future: createItem(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint("snapshot has Data");
          return ItemsList(items: snapshot.data!);
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.data}');
          debugPrint("snapshot doesnt has Data");
          debugPrint('${snapshot.stackTrace}');
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class ItemsList extends StatefulWidget {
  const ItemsList({Key? key, required this.items}) : super(key: key);

  final List<Item> items;

  @override
  _ItemsList createState() => _ItemsList();
}

class _ItemsList extends State<ItemsList> {
  late List<Item> items = [];
  // final _checked = <Item> [];
  bool checkboxvalue = false;
  // void _onRememberMeChanged(bool newValue) => setState(() {
  //   checkboxvalue = newValue;
  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     childAspectRatio: 3 / 2,
      //     crossAxisSpacing: 20,
      //     mainAxisSpacing: 20,
      //     crossAxisCount: 2),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.01,
            ),
            width: MediaQuery.of(context).size.width * 0.94,
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[400]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${items[index].name} : ${items[index].quantity}',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width *
                              MediaQuery.of(context).size.height *
                              0.000045),
                    ),
                    Checkbox(
                        value: items[index].value,
                        onChanged: (val) {
                          setState(() {
                            debugPrint(
                                "this should send a delete  post request");
                            deleteItem(http.Client(), items[index].id);
                            items[index].value = val!;
                          });
                        })
                  ],
                ),
                // Divider(
                //   color: Colors.grey,
                //   height: 1.0,
                //   indent: 30.0,
                //   endIndent: 30.0,
                // ),
                Text(
                  items[index].category,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        MediaQuery.of(context).size.height *
                        0.00004,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ));
      },
    );
  }
}
