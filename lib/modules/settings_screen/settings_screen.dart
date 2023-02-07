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

class Settings_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Layout_Cubit,LayoutStates>(
      listener: (context,state){},
      builder:  (context,state){
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConditionalBuilder(
                condition: state is! GetUserLoadingState ,
                fallback:(context) => Center(child: CircularProgressIndicator()) ,
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
                                          Layout_Cubit.get(context).userModel!.cover!
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
                                    Layout_Cubit.get(context).userModel!.image!,
                                  ),
                                  radius: 65,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          Layout_Cubit.get(context).userModel!.name!,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          Layout_Cubit.get(context).userModel!.bio!,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16
                          ),
                        ),
                        SizedBox(height: 10,),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: (){
                                  navigatorTo(context, New_Post_Screen());
                                },
                                child: Text('Add new post'),
                              ),
                            ),
                            SizedBox(width: 5,),
                            OutlinedButton(
                              onPressed: (){
                                navigatorTo(context,Edit_Profile_Screen());
                              },
                              child: Icon(IconBroken.Edit,size: 20),
                            ),

                          ],
                        ),


                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10,),
              TextButton(
                  onPressed: (){
                    Layout_Cubit.get(context).changeShownMyPosts();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                     ! Layout_Cubit.get(context).showMyPosts ?  'Show your posts..' : 'Hide your posts',
                      style: TextStyle(fontSize: 18),),
                  ) ,
              ),
              SizedBox(height: 20,),
              if(Layout_Cubit.get(context).showMyPosts)
              ConditionalBuilder(
                  condition:state is! LoadingGetMyPostsState && Layout_Cubit.get(context).myposts.length !=0,
                  fallback: (BuildContext context) {
                    return Container();
                  },
                  builder: (context){
                    return Container(
                      //padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey[200],
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildPost(context,Layout_Cubit.get(context).myposts[index],true),
                        separatorBuilder: (context,index)=> SizedBox( height:15 ),
                        itemCount: Layout_Cubit.get(context).myposts.length,
                      ),
                    );
                  }
              ),
            ],
          ),
        );

      } ,
    );
  }
}
