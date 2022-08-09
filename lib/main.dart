import 'package:flutter/material.dart';
import 'package:furniture_app/providers/auth%20provider.dart';
import 'package:furniture_app/providers/driver%20provider.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:furniture_app/providers/user%20provider.dart';
import 'package:furniture_app/screens/choose%20user%20type.dart';
import 'package:furniture_app/screens/final%20order%20screen.dart';
import 'package:furniture_app/screens/helper%20screen.dart';
import 'package:furniture_app/screens/items%20screen.dart';
import 'package:furniture_app/screens/location%20screen.dart';
import 'package:furniture_app/screens/login%20screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:furniture_app/screens/profile%20screen.dart';
import 'package:furniture_app/screens/register%20driver.dart';
import 'package:furniture_app/screens/register%20screen.dart';
import 'package:furniture_app/screens/select%20car%20type.dart';
import 'package:furniture_app/screens/select%20day%20and%20time%20screen.dart';
import 'package:furniture_app/screens/select%20driver.dart';
import 'package:furniture_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => DriverProvider(),),
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
        ChangeNotifierProvider(create: (context) => OrderProvider(),),
        ChangeNotifierProvider(create: (context) => UserProvider(),)
      ],

        title: 'Flutter Demo',
        theme: ThemeData(
    child: MaterialApp(

          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

