import 'package:flutter/material.dart';
import 'package:market_app/classes/super_market.dart';

import '../../http/client.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [],
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
