import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/models/userModel.dart';
import 'package:jobs_for_all/modules/chat_details/chat_details.dart';

import '../../shared/components/components.dart';

class Chats_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Layout_Cubit,LayoutStates>(
      listener: (context,state){},
      builder:  (context,state){
        return ConditionalBuilder(
          condition: Layout_Cubit.get(context).chatsList.length>0 && state is !LoadingGetChatstState ,
          builder: (context){
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(Layout_Cubit.get(context).chatsList[index],context),
              separatorBuilder: (context,index)=>mydivider(),
              itemCount:Layout_Cubit.get(context).chatsList.length,
            );
          },
          fallback: (context)=>Center(
             child: Text('No chats',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 20)),
          ),
        );
      } ,
    );
  }


  Widget buildChatItem ( UserModel model,context){
    return InkWell(
      onTap: (){
        navigatorTo(context, Chat_Details_Screen(model: model));
      },
      child: Padding(
        padding: EdgeInsetsDirectional.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: ExtendedNetworkImageProvider(
                model.image!,
              ),
            ),
            SizedBox(width: 10),
            Text(
              model.name!,
              style: TextStyle(
                height: 1.2,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
