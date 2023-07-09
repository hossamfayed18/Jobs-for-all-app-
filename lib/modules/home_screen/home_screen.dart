import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';

import '../../shared/style/colors.dart';

class Home_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit =Layout_Cubit.get(context);
    return BlocConsumer<Layout_Cubit,LayoutStates>(
        listener: (context,state){},
      builder:  (context,state){
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              //color: Colors.grey[200],
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 25
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        const Image(
                          image: AssetImage(
                              'assets/images/img2.jpg'
                          ),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '',
                            style:Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(

                      right: 70,
                      left: 70,
                    ),
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        elevation: 0,
                        menuMaxHeight: 300.0,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black,width: 3,),
                          ),
                        ),
                        alignment: AlignmentDirectional.center,
                        items: [
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.getAllPosts();
                            },
                            value:'all jobs' ,
                            child: Text("all jobs",style: TextStyle(fontSize: 16,color:defaultcolor),),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.getengineeringPosts();
                            },
                            value:cubit.jobCtegory[0] ,
                            child: Text(cubit.jobCtegory[0],style: TextStyle(fontSize: 16,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.gettechnologyPosts();
                            },
                            value:cubit.jobCtegory[1] ,
                            child: Text(cubit.jobCtegory[1],style: TextStyle(fontSize: 16,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.geteducationPosts();
                            },
                            value:cubit.jobCtegory[2] ,
                            child: Text(cubit.jobCtegory[2],style: TextStyle(fontSize: 16,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.geteJournalismPosts();
                            },
                            value:cubit.jobCtegory[3] ,
                            child: Text(cubit.jobCtegory[3],style: TextStyle(fontSize: 15,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.geteManagementPosts();
                            },
                            value:cubit.jobCtegory[4] ,
                            child: Text(cubit.jobCtegory[4],style: TextStyle(fontSize: 15,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.geteMedicalPosts();
                            },
                            value:cubit.jobCtegory[5] ,
                            child: Text(cubit.jobCtegory[5],style: TextStyle(fontSize: 16,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.geteFreelancePosts();
                            },
                            value:cubit.jobCtegory[6] ,
                            child: Text(cubit.jobCtegory[6],style: TextStyle(fontSize: 15,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.getTourismPosts();
                            },
                            value:cubit.jobCtegory[7] ,
                            child: Text(cubit.jobCtegory[7],style: TextStyle(fontSize: 15,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.getlawPosts();
                            },
                            value:cubit.jobCtegory[8] ,
                            child: Text(cubit.jobCtegory[8],style: TextStyle(fontSize: 16,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.getTranslationPosts();
                            },
                            value:cubit.jobCtegory[9] ,
                            child: Text(cubit.jobCtegory[9],style: TextStyle(fontSize: 15,color:defaultcolor)),
                          ),
                          DropdownMenuItem(
                            alignment: Alignment.center,
                            onTap: (){
                              cubit.getothersPosts();
                            },
                            value:cubit.jobCtegory[10] ,
                            child: Text(cubit.jobCtegory[10],style: TextStyle(fontSize: 16,color:defaultcolor,),),
                          ),
                        ],
                        value: cubit.selectedItem_ ,
                        onChanged: (item){
                          cubit.changeItem_DropDownMenue_(item!);
                        },
                      ),
                    ),
                  ),
                  ConditionalBuilder(
                      condition:state is! LoadingGetAllPostsState && state is! LoadingGetCatPostsState ,
                      fallback: (BuildContext context) {
                        return CircularProgressIndicator();
                      },
                      builder: (context){
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>buildPost(context,Layout_Cubit.get(context).mylist[index],false),
                          separatorBuilder: (context,index)=> SizedBox( height:15 ),
                          itemCount: Layout_Cubit.get(context).mylist.length,
                        );
                      }
                  ) ,
                  const SizedBox(height: 8,),
                ],
              ),
            ),
          );
      } ,
    );
  }




}
