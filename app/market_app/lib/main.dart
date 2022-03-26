import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_app/screens/Login/login_screen.dart';
import 'package:market_app/screens/home/home.dart';
import 'package:market_app/screens/root/root.dart';
import 'package:market_app/screens/singup/signup_screen.dart';
import 'package:market_app/screens/welcome/welcome_screen.dart';
import 'details/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  // This appears to result in native full screen mode
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'MarketApp';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      theme: ThemeData(
        primaryColor: primaryGrey,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RootPage(),
        '/items': ((context) => const HomeScreen()),
        '/welcome': ((context) => const WelcomeScreen()),
        '/login': ((context) => const LoginScreen()),
        '/signup': ((context) => const SignupScreen())
      },
    );
  }
}
