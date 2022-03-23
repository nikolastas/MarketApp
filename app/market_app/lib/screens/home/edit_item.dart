import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_app/details/colors.dart';
import '../../classes/Category.dart';
import '../../classes/Items.dart';
import '../../http/client.dart';

class EditItems extends StatefulWidget {
  final Item editableItem;
  EditItems({Key? key, required this.editableItem}) : super(key: key);

  @override
  _EditItems createState() => _EditItems();
}

class _EditItems extends State<EditItems> {
  late String changed_item_name;
  late String changed_category;
  late int changed_quantity;
  TextEditingController c1 = TextEditingController();

  TextEditingController c2 = TextEditingController();
  Future<List<Category>>? futureCategory;
  String? _selected = null;

  @override
  void initState() {
    super.initState();
    changed_category = widget.editableItem.category!;
    changed_item_name = widget.editableItem.itemName!;
    changed_quantity = widget.editableItem.quantity!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
        backgroundColor: Colors.deepPurple[400],
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.indigo,
        icon: Icon(Icons.done_sharp),
        onPressed: () async {
          var myMap = <String, String>{};
          var flag = false;
          if (c1.text != "" && c1.text != widget.editableItem.itemName) {
            myMap.addAll({"item_name": c1.text});
            flag = true;
            print(c1.text);
          } else {
            myMap.addAll({"item_name": widget.editableItem.itemName!});
          }
          if (c2.text != "" && c2.text != widget.editableItem.quantity) {
            myMap.addAll({"quantity": c2.text});
            flag = true;
            print(c2.text);
          } else {
            myMap.addAll({"quantity": widget.editableItem.quantity.toString()});
          }
          if (changed_category != widget.editableItem.category) {
            flag = true;
            myMap.addAll({"category": changed_category});
            print(changed_category);
          } else {
            myMap.addAll({"category": widget.editableItem.category!});
          }
          if (flag) {
            myMap.addAll({"_id": (widget.editableItem.iId).toString()});
            print(myMap);
            await ApiClient().updateItem(widget.editableItem.iId!, myMap);

            Navigator.pop(
              context,
            );
          } else {
            Navigator.pop(context);
          }
        },
        label: Text("Done"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29), color: primaryGrey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Item Name :"),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          controller: c1,
                          decoration:
                              InputDecoration(hintText: changed_item_name),
                          maxLines: 1,
                          maxLength: 30,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Item Category :"),
                      SizedBox(
                        width: 8,
                      ),
                      buildFutureCategories(),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Item Quantity :"),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                            controller: c2,
                            decoration: InputDecoration(
                                hintText: changed_quantity.toString()),
                            keyboardType: TextInputType.number),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Category>> buildFutureCategories() {
    return FutureBuilder<List<Category>>(
      future: ApiClient().createCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> categories = snapshot.data!
              .map<String>((Category value) {
                return (value.name.toString());
              })
              .toSet()
              .toList();
          categories.map(
            (e) => print(e),
          );
          return DropdownButton<String>(
            value: _selected,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 30,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                _selected = newValue;
              });
            },
            items: snapshot.data!
                .map((Category e) => DropdownMenuItem<String>(
                      child: Text(e.name),
                      value: e.name,
                    ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
