import 'package:flutter/material.dart';

class EditItems extends StatelessWidget {
  final String name ;
  final List<String> categories;
  final String category;
  final int quantity;
  const EditItems({ Key? key,required this.categories, required this.category, required this.name, required this.quantity }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item"),
      backgroundColor: Colors.deepPurple[400],),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text("Item Name :"),
                SizedBox(width: 8,),
                Expanded(
                  child: TextField(
                    controller: TextEditingController()..text = name,

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
                  items: categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: category,
                  onChanged: (String) {} 
                )
              ],
            ),
            Row(
              children: [
                Text("Item Quantity :"),
                SizedBox(width: 8,),
                Expanded(
                  child: TextField(
                    controller: TextEditingController()..text = (quantity.toString()) ,
                    keyboardType: TextInputType.number
                  ),
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}