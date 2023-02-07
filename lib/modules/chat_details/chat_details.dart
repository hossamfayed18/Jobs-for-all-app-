import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/models/userModel.dart';
import 'package:jobs_for_all/shared/style/colors.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';
import '../../models/message_model.dart';

class Chat_Details_Screen extends StatelessWidget {

  final UserModel model ;

  Chat_Details_Screen({required this.model});

  @override
  Widget build(BuildContext context) {

    return  Builder(builder: (BuildContext context) {

      Layout_Cubit.get(context).getMessages(model.uid!);

      return  BlocConsumer<Layout_Cubit,LayoutStates>(

        listener:(context,state){

        } ,
        builder:(context,state){
          var messageController =TextEditingController();
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: ExtendedNetworkImageProvider(
                      model.image!,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    model.name!,
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition:true,//SocialCubit.get(context).messages.length!=0 ,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
              builder: (context){
                return Padding(
                  padding: EdgeInsetsDirectional.all(20),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              if(Layout_Cubit.get(context).userModel!.uid==Layout_Cubit.get(context).messages[index].senderId)
                                return buildMyMessage(Layout_Cubit.get(context).messages[index]);
                              else
                                return buildFriendMessage(Layout_Cubit.get(context).messages[index]);
                            },
                            separatorBuilder: (context,index)=>SizedBox(height: 15,),
                            itemCount: Layout_Cubit.get(context).messages.length ,
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding:EdgeInsetsDirectional.only(
                          start: 15,


                        ) ,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: 'type your message here...',
                                  border: InputBorder.none,

                                ),
                              ),
                            ),
                            Container(
                              height: 55,
                              color: defaultcolor,
                              child: MaterialButton(
                                onPressed:(){
                                  var now =DateTime.now();
                                  Layout_Cubit.get(context).sendMessage(
                                    recieverId: model.uid!,
                                    text: messageController.text,
                                    dateTime:now.toString() ,
                                  );
                                } ,
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                minWidth: 1.0,


                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } ,
      );
    },

    );
  }

  Widget buildFriendMessage(MessageModel model ){
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd:Radius.circular(10) ,
            )
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal:10 ,
        ),
        child: Text(
            model.text!
        ),
      ),
    ) ;
  }

  Widget buildMyMessage(MessageModel model ){
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: defaultcolor,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart:Radius.circular(10) ,
            )
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal:10 ,
        ),
        child: Text(
          model.text!,
        ),
      ),
    ) ;
  }

}
