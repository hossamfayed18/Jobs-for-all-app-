import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jobs_for_all/shared/style/colors.dart';

ThemeData darkthemeData = ThemeData(
  scaffoldBackgroundColor: HexColor('4C4C4C'),
  primarySwatch: defaultcolor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
    ),
    titleSpacing: 20,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  HexColor('4C4C4C'),
      statusBarIconBrightness: Brightness.light,
    ),
    color: HexColor('4C4C4C'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,

    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    //centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor:HexColor('4C4C4C') ,
    selectedIconTheme:  IconThemeData(
      color: defaultcolor,
    ),
    unselectedIconTheme: IconThemeData(
        color: Colors.grey
    ),
    elevation: 20.0,
    type:BottomNavigationBarType.fixed,

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color:   Colors.white ,
      )
  ),
  fontFamily: 'Jannah',

);
ThemeData lightthemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch:defaultcolor ,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleSpacing: 20,
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,

    ),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Jannah',

    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    //centerTitle: true,
  ),
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    selectedIconTheme:  IconThemeData(
      color: defaultcolor,
    ),
    unselectedIconTheme: IconThemeData(
        color: Colors.grey
    ),
    backgroundColor: Colors.white,
    elevation: 20.0,
    type:BottomNavigationBarType.fixed,


  ),

  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17,
        color: Colors.black ,
      )
  ),
  fontFamily: 'Jannah',

);