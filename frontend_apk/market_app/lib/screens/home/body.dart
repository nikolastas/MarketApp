import 'package:flutter/material.dart';

import 'package:market_app/http/client.dart';
import 'package:market_app/http/requests.dart';
import 'package:market_app/screens/home/edit_item.dart';
import '../../http/client.dart';
import '../../classes/Items.dart';
import '../../components/rounded_button.dart';
import '../../details/colors.dart';
import '../root/root.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _BodyState();
}

class _BodyState extends State<HomeScreenBody> {
  Future<List<ItemsList>>? _futureItemsList;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
        onRefresh: () async {}, child: Stack(children: [buildFutureBuilder()]));
  }

  FutureBuilder<List<Item>> buildFutureBuilder() {
    return FutureBuilder<List<Item>>(
      future: ApiClient().createItem(),
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

        return const Center(child: CircularProgressIndicator());
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
  // late List<Category> categories =[];
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
              top: MediaQuery.of(context).size.width * 0.06,
            ),
            width: MediaQuery.of(context).size.height * 0.95,
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: (items[index].aboutToDelete == true)
                    ? Colors.red
                    : Colors.grey[500]),
            child:

                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,

                InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditItems(
                              editableItem: items[index],
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                      value: items[index].aboutToDelete,
                      shape: CircleBorder(),
                      checkColor: primaryPink,
                      onChanged: (val) async {
                        setState(() {
                          items[index].aboutToDelete = val!;
                        });
                        await Future.delayed(Duration(seconds: 3));
                        if (items[index].aboutToDelete == true) {
                          debugPrint(
                              "this should send a delete  post request to item ${items[index].iId}");

                          var response =
                              await ApiClient().deleteItem(items[index].iId!);
                          if (response.statusCode == 200) {
                            setState(() {
                              items.removeAt(index);
                            });
                          }
                        }
                      }),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${items[index].itemName} : ${items[index].quantity}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width *
                                  MediaQuery.of(context).size.height *
                                  0.000075),
                        ),
                        Text(
                          '${items[index].category}',
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
                ],

                // Divider(
                //   color: Colors.grey,
                //   height: 1.0,
                //   indent: 30.0,
                //   endIndent: 30.0,
                // ),
              ),
            ),
          );
        });
  }
}
