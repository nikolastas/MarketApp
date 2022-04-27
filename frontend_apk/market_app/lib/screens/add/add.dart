import 'package:flutter/material.dart';
import 'package:market_app/components/rounded_button.dart';
import 'package:market_app/details/colors.dart';

import '../../classes/Category.dart';
import '../../http/client.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController c1 = TextEditingController();

  TextEditingController c2 = TextEditingController();
  String? _selected = null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.65,
                  decoration: BoxDecoration(
                      color: primaryGrey,
                      borderRadius: BorderRadius.circular(29)),
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
                            borderRadius: BorderRadius.circular(29),
                            color: primaryGrey),
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
                                        InputDecoration(hintText: "item name"),
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
                              ],
                            ),
                            buildFutureCategories(),
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
                                    hintText: "1",
                                  ),
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Map<String, String> body = {
                    "item_name": c1.text,
                    "category": _selected!,
                    "quantity": c2.text
                  };
                  var response = await ApiClient().addItem(body);
                  if (response.statusCode == 200) {
                    print("item added");
                    c1.clear();
                    c2.clear();
                    _selected = null;
                  } else {
                    print(response.body);
                  }
                },
                label: Text(
                  "Add Item",
                  style: TextStyle(color: secondaryBlack),
                ),
                icon: Icon(
                  Icons.add,
                  color: secondaryBlack,
                ),
                backgroundColor: Color.fromARGB(255, 204, 90, 90),
              ),
            )
          ]),
        ],
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
                return (value.name);
              })
              .toSet()
              .toList();

          return DropdownButton<String>(
            value: _selected,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 30,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                _selected = newValue!;
              });
            },
            items: categories.map((e) {
              return DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
