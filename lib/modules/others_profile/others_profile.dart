import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/modules/edit_Profile/edit_profile_Screen.dart';
import 'package:jobs_for_all/modules/new_post_screen/new_post_screen.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';

class Others_Profile_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<Layout_Cubit,LayoutStates>(
      listener: (context,state){},
      builder:  (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConditionalBuilder(
                  condition: state is! GetOtherUserLoadingState,
                  fallback:(context) => Center(child: CircularProgressIndicator()),
                  builder: (context){
                    return Padding(
                      padding: EdgeInsetsDirectional.all(8),
                      child: Column(
                        children: [
                          Container(
                            height: 227,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 155,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: ExtendedNetworkImageProvider(
                                            Layout_Cubit.get(context).otherUserModel!.cover!
                                        ),
                                        fit: BoxFit.cover,

                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight:Radius.circular(5) ,
                                        topLeft:Radius.circular(5) ,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 67,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    backgroundImage: ExtendedNetworkImageProvider(
                                      Layout_Cubit.get(context).otherUserModel!.image!,
                                    ),
                                    radius: 65,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            Layout_Cubit.get(context).otherUserModel!.name!,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            Layout_Cubit.get(context).otherUserModel!.bio!,
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Layout_Cubit.get(context).addUserTOChats();
                                   },
                                  child: Row(
                                    children: [
                                      Icon(IconBroken.Chat),
                                      SizedBox(width: 5,),
                                      Text('add to your chats',style: TextStyle(fontSize: 18),),
                                    ],
                                  ) ,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10,),
                ConditionalBuilder(
                    condition:state is! LoadingGetOtherPostsState && Layout_Cubit.get(context).otherPosts.length !=0,
                    fallback: (BuildContext context) {
                      return Container();
                    },
                    builder: (context){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.grey[200],
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>buildPost(context,Layout_Cubit.get(context).otherPosts[index],true),
                          separatorBuilder: (context,index)=> SizedBox( height:15 ),
                          itemCount: Layout_Cubit.get(context).otherPosts.length,
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        );

      } ,
    );
  }
}
