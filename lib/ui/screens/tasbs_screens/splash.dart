import 'dart:async';

import 'package:ToDODataBase/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
        Timer(Duration(seconds:5), () => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainScreen())));
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        
        children: <Widget>[
          
          Container(
           child: Image.asset('assets/images/image.png', fit: BoxFit.contain,),
            decoration: BoxDecoration(color: Colors.pink),
          ),
           Positioned(
            child: Text("Todos", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
            top: 40,
            left: 20,
          ),
       ],
      ),
    );
  }
}