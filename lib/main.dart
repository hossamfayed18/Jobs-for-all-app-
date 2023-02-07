import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/Layout_screen.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/modules/login/login_screen.dart';
import 'package:jobs_for_all/modules/new_post_screen/new_post_screen.dart';
import 'package:jobs_for_all/modules/on_boarding/on_boarding_screen.dart';
import 'package:jobs_for_all/modules/welcome_screen/welcome_screen.dart';
import 'package:jobs_for_all/shared/bloc_observer.dart';
import 'package:jobs_for_all/shared/network/cache_helper.dart';
import 'package:jobs_for_all/shared/style/themes/themes.dart';

import 'shared/components/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
   
  
  uid = CacheHelper.getData(key: 'uid');

  
  runApp(MyApp());

       //Myapp here calls 1- empty constructor 2-build method
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
         create: (context)=>Layout_Cubit()..getUser()..getAllPosts()..getMyPosts()..getChats(),
         child:BlocConsumer<Layout_Cubit,LayoutStates>(
           listener:(context,state){} ,
           builder: (context,state){
             return MaterialApp(
               theme: lightthemeData,
               darkTheme: darkthemeData,
               themeMode:  ThemeMode.light,
               debugShowCheckedModeBanner: false,
               home : On_boarding(),
             );
           },
         ) ,
     );
  }


}