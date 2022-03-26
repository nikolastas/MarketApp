import 'package:flutter/material.dart';
import 'package:market_app/details/colors.dart';

import '../../classes/Items.dart';
import '../../http/client.dart';

class ShortedMarketItems extends StatefulWidget {
  const ShortedMarketItems({Key? key, required this.super_marker_name})
      : super(key: key);
  final String super_marker_name;
  @override
  State<ShortedMarketItems> createState() => _ShortedMarketItemsState();
}

class _ShortedMarketItemsState extends State<ShortedMarketItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [buildFutureBuilder(widget.super_marker_name)],
      ),
    );
  }

  FutureBuilder<List<Item>> buildFutureBuilder(String super_marker_name) {
    return FutureBuilder<List<Item>>(
      future: ApiClient().shortedItemsList(super_marker_name),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint("snapshot has Data");
          return ShortedItemList(shorted_list: snapshot.data!);
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.data}');
          debugPrint("snapshot doesnt has Data");
          debugPrint('${snapshot.stackTrace}');
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ShortedItemList extends StatefulWidget {
  const ShortedItemList({Key? key, required this.shorted_list})
      : super(key: key);
  final List<Item> shorted_list;
  @override
  State<ShortedItemList> createState() => _ShortedItemListState();
}

class _ShortedItemListState extends State<ShortedItemList> {
  late List<Item> shorted_list = [];
  @override
  Widget build(BuildContext context) {
    shorted_list = widget.shorted_list;
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: shorted_list.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: primaryGrey, borderRadius: BorderRadius.circular(29)),
              width: size.width * 0.9,
              height: size.height * 0.12,
              child: Column(
                children: [
                  Text(
                    shorted_list[index].itemName!,
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: size.height * 0.1 / 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.shopping_bag),
                      Text("Ποσότητα:"),
                      Text(
                        "${shorted_list[index].quantity}",
                        style: TextStyle(fontSize: 17),
                      ),
                      Icon(Icons.category),
                      Text(shorted_list[index].category!)
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 0,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
          ],
        );
      },
    );
  }
}
