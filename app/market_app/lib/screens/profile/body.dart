import 'package:flutter/material.dart';
import 'package:market_app/classes/user.dart';

import '../../components/rounded_button.dart';
import '../../details/colors.dart';
import '../../http/client.dart';
import '../root/root.dart';
import '../../http/client.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.89,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                  color: primaryGrey, borderRadius: BorderRadius.circular(29)),
              child: Column(
                children: [
                  Icon(
                    Icons.person_pin_rounded,
                    size: size.width * 0.5,
                  ),
                  futureBuilder(size.width * 0.89, size.height * 0.6),
                ],
              ),
            ),
            RoundedButton(
                width: size.width * 0.8,
                text: "Logout",
                press: () async {
                  var response = await ApiClient().logout();
                  if (response) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => RootPage()),
                        (route) => false);
                  }
                },
                textcolor: secondaryBlack,
                backgroundColor: secondaryYellow)
          ],
        ),
      ],
    );
  }

  FutureBuilder<List<String?>> futureBuilder(double width, double height) {
    return FutureBuilder<List<String?>>(
        future: Future.wait([
          storage.read(key: "username"),
          storage.read(key: "email"),
          storage.read(key: "group")
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: secondaryBlack,
                  ),
                ),
                Text(
                  snapshot.data![0]!,
                  style: TextStyle(fontSize: 32, height: 1.4),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "email",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: secondaryBlack,
                  ),
                ),
                Text(
                  snapshot.data![1]!,
                  style: TextStyle(fontSize: 32, height: 1.4),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Group",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: secondaryBlack,
                  ),
                ),
                Text(
                  snapshot.data![2]!,
                  style: TextStyle(fontSize: 32, height: 1.4),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
