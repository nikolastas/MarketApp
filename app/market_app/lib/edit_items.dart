import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> updateItem(String j) async {
  print("i am about to update an item");
  final response = await http.post(
      Uri.parse('https://marketapp2022.azurewebsites.net/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: j);
  if (response.statusCode == 200) {
    print("updated item successfully");
    return ;
  } else {
    print("something went wrong with the update of the item");
    return ;
  }
}


class EditItems extends StatefulWidget {
  String name ;
  List<String> categories;
  String category;
  int quantity;
  var id;
  EditItems({ Key? key, required this.id ,required this.categories, required this.category, required this.name, required this.quantity }) : super(key: key);

  @override
  _EditItems createState() => _EditItems();
}
class _EditItems extends State<EditItems>{
  late String changed_item_name ;
  late String changed_category ;
  late int changed_quantity ;
  TextEditingController c1 = TextEditingController() ;
  
  TextEditingController c2 = TextEditingController() ;


  @override
  void initState() {
    super.initState();
    changed_category = widget.category;
    changed_item_name = widget.name;
    changed_quantity = widget.quantity;
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
          var list =<String, dynamic> {"id":widget.id};
          var flag = false;
          if(c1.text != "" && c1.text != widget.name ){
            list.addAll({"item_name": c1.text});
            flag =true;
            print(c1.text);
          }
          else{
            list.addAll({"item_name": widget.name});
          }
          if(c2.text != "" && c2.text != widget.name ){
            list.addAll({"quantity":c2.text});
            flag = true;
            print(c2.text);
          }
          else{
            list.addAll({"quantity":widget.quantity});
          }
          if(changed_category != widget.category){
            flag =true;
            list.addAll({"category":changed_category });  
            print(changed_category );
          }else{
            list.addAll({"category":widget.category});
          }
          if(flag){
            list.addAll({"collection_name":"MarketItems"});
            var j = jsonEncode(list);
            await updateItem(j);
            list.addAll({"_id":widget.id});
            (c2.text != "" && c2.text != widget.name)? list["quantity"]= int.parse(list["quantity"]): list["quantity"]=widget.quantity;
            Navigator.pop(context, list);
          }
          else{
            
            Navigator.pop(context, list);
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
                          hintText: changed_item_name
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
                          hintText: changed_quantity.toString()
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