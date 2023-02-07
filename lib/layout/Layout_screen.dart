import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/modules/new_post_screen/new_post_screen.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';

class Layout_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Layout_Cubit.get(context) ;
    return BlocConsumer<Layout_Cubit,LayoutStates>(
        listener: (context,state){
        if(state is AddNewPostState)
          navigatorTo(context, New_Post_Screen());
        },
      builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.current_index],
              ),
            ),
            body: cubit.screens[cubit.current_index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.current_index,
              onTap: (index){
                cubit.changeBottomNavIndex(index) ;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ) ,
                  label: 'Home',

                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ) ,
                  label: 'Chats',

                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ) ,
                  label: 'Post',

                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ) ,
                  label: 'Settings',

                ),

              ],
            ),
          );
      },
    );
  }
}
