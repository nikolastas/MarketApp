import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> addItem(String j) async {
  print("i am about to update an item");
  final response = await http.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: j);
  return response;
}


class AddItems extends StatefulWidget {
  // String name ;
  final List<String> categories;
  // final String category;
  // int quantity;
  
  const AddItems({ Key? key, required this.categories}) : super(key: key);

  @override
  _AddItems createState() => _AddItems();
}
class _AddItems extends State<AddItems>{
  late String changed_item_name ;
  late String changed_category ;
  late int changed_quantity ;
  TextEditingController c1 = TextEditingController() ;
  
  TextEditingController c2 = TextEditingController() ;


  @override
  void initState() {
    super.initState();
    // print(widget.categories);
    changed_category = widget.categories.elementAt(0);
    // changed_item_name = widget.name;
    // changed_quantity = widget.quantity;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item"),
      backgroundColor: Colors.deepPurple[400],),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.indigo,
        icon: Icon(Icons.done_sharp),
        onPressed: () async { 
          
          var response = await addItem(jsonEncode(<String, String>{ 
          "collection_name":"MarketItems", 
          "quantity":c2.text, 
          "category":(changed_category == null)? "Άλλα προιόντα":changed_category, 
          "item_name":c1.text}));
          if (response.statusCode == 200) {
            print("updated item successfully");
            Navigator.pop(context);
          } else {
            
            print(response.body);
            print("something went wrong with the update of the item");
            
          }
          
         }, label: Text("Done"),),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.width*0.1,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width*0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("Item Name :"),
                    SizedBox(width: 8,),
                    Expanded(
                      child: TextField(
                        controller: c1,
                        decoration: InputDecoration(
                          // hintText: changed_item_name
                        ),
                        maxLines: 1,
                        maxLength: 30,
                    
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Item Category :"),
                    SizedBox(width: 8,),
                    DropdownButton(
                      items: widget.categories.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: changed_category,
                      onChanged: (String? newValue) {
                        setState(() {changed_category = newValue!;});
                      } 
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Item Quantity :"),
                    SizedBox(width: 8,),
                    Expanded(
                      child: TextField(
                        controller: c2 ,
                        decoration: InputDecoration(
                          // hintText: changed_quantity.toString()
                        ),
                        keyboardType: TextInputType.number
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}