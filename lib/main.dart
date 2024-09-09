import 'package:flutter/material.dart';
import 'package:news_1am/modules/home/pages/home_screen.dart';
import 'modules/splahs/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News 1PM',
        theme: ThemeData(
          useMaterial3: false,
        ),
        // home: TabsScreen(),
        routes: {
          SplashScreen.routeName: (_) => SplashScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
        },
        initialRoute: SplashScreen.routeName
        //   ,
        );
  }
}
