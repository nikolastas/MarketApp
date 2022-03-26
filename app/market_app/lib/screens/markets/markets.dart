import 'package:flutter/material.dart';
import 'package:market_app/classes/super_market.dart';
import 'package:market_app/details/colors.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:market_app/screens/markets/shorted_items.dart';
import '../../http/client.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGrey,
      body: Stack(
        children: [buildFutureBuilder()],
      ),
    );
  }

  FutureBuilder<List<SuperMarket>> buildFutureBuilder() {
    return FutureBuilder<List<SuperMarket>>(
      future: ApiClient().markets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint("snapshot has Data");
          return SuperMarketList(markets: snapshot.data!);
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

class SuperMarketList extends StatefulWidget {
  const SuperMarketList({Key? key, required this.markets}) : super(key: key);
  final List<SuperMarket> markets;
  @override
  State<SuperMarketList> createState() => _SuperMarketListState();
}

class _SuperMarketListState extends State<SuperMarketList> {
  List<SuperMarket> markets = [];
  @override
  void initState() {
    super.initState();
    markets = widget.markets;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     childAspectRatio: 3 / 2,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //     crossAxisCount: 2),
        itemCount: markets.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  print("pressed");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShortedMarketItems(
                                super_marker_name:
                                    markets[index].SuperMarketName,
                              )));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.all(8),
                  width: size.width * 0.8,
                  height: size.width * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    children: [
                      Text(
                        markets[index].SuperMarketName,
                        style: TextStyle(fontSize: 26),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      InkWell(
                        onTap: () {
                          MapsLauncher.launchQuery(markets[index].Address);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on),
                            Text(markets[index].Address),
                          ],
                        ),
                      )
                    ],
                  ),
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
        });
  }
}
