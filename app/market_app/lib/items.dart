import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:market_app/edit_items.dart';

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
class Category{
  final int id;
  final String name;
  Category({required this.id,required this.name});
  factory Category.fromJson(Map<String, dynamic> json){
    return Category(id: json["_id"], name: json["name"]);
  }
}

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
    return ;
  } else {
    print("something went wrong");
    return ;
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
  late List<Category> categories =[];
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     childAspectRatio: 3 / 2,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //     crossAxisCount: 2),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
              
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.06,
                
              ),
              width: MediaQuery.of(context).size.height * 0.95,
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: items[index].value ?Colors.red :Colors.grey[500]),
              child: 
                
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                
                  InkWell(
                    onTap: () async { 
                      print("pressed");
                      categories = await createCategories(http.Client());
                      Navigator.push(context,MaterialPageRoute(builder: (context) => EditItems(category: items[index].category,categories: categories.map((e) => e.name).toList(), quantity: items[index].quantity, name: items[index].name)));
                      
                    },
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.shopping_basket),
                        Container(
                          width: MediaQuery.of(context).size.height * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 10,),
                              Text(
                                '${items[index].name} : ${items[index].quantity}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width *
                                        MediaQuery.of(context).size.height *
                                        0.000075),
                              ),
                              Text(
                            items[index].category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width *
                              MediaQuery.of(context).size.height *
                              0.00006,
                              letterSpacing: 1.0,
                            ),
                          ),
                            ],
                          ),
                        ),
                        
                        // Divider(
                        //   color: Colors.grey,
                        //   height: 1.0,
                        //   indent: 30.0,
                        //   endIndent: 30.0,
                        // ),
                        Checkbox(
                                    value: items[index].value,
                                    onChanged: (val) async{
                                      items[index].value = val!;
                                      setState(() {
                                        debugPrint(
                                            "this should send a delete  post request");
                                        items[index].value = val;
                                      });
                                      
                                      if(items[index].value == true){
                                        
                                        // await deleteItem(items[index].id);
                                        print("I am in, ${index}");
                                        await Future.delayed(Duration(seconds: 5));
                                        print("5 second passed");
                                        if(items[index].value == true){
                                          await deleteItem(items[index].id);
                                          setState(() {
                                          items.remove(items[index]);
                                          });
                                        
                                        }                                    
                                        
                                      }
                                      
                                    }
                                  ),
                        
                                  ],
                                ),
                  ),
                  );
        },
      ),
    );
  }
}
