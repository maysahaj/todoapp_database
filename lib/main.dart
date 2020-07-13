import 'package:ToDODataBase/providers/db_provider.dart';
import 'package:ToDODataBase/ui/screens/main_screen.dart';
import 'package:ToDODataBase/ui/screens/tasbs_screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBProvider>(
      create: (BuildContext context) {
        return DBProvider();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        home:SplashScreen(),
        theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink[800], //Changing this will change the color of the TabBar
        accentColor: Colors.pink,
      ),
      ),
    );
  }
}
