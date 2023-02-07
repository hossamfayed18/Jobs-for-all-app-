import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/style/colors.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';

class New_Post_Screen extends StatelessWidget { 
  var mykey =GlobalKey<FormState>();
  var descriptionController =TextEditingController();
  var phoneOrEmailController =TextEditingController();
  var requirementsController =TextEditingController();
  var placeController =TextEditingController();
  var notesController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = Layout_Cubit.get(context);
    return BlocConsumer<Layout_Cubit,LayoutStates>(
      listener: (context,state){},
      builder:  (context,state){
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundImage: ExtendedNetworkImageProvider(
                    Layout_Cubit.get(context).userModel!.image!,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  Layout_Cubit.get(context).userModel!.name!,
                  style: TextStyle(fontSize: 21),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: mykey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(

                  children: [

                    TextFormField(
                      validator: (value){
                        if(value.toString().isEmpty)
                          return 'please,write the descreption';
                        return null;
                      },
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: 'Write the description ...',
                        border:InputBorder.none ,
                      ),
                      controller: descriptionController,
                    ),
                    SizedBox(height: 10),
                    if(Layout_Cubit.get(context).postImage!=null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                            image:DecorationImage(image:FileImage(Layout_Cubit.get(context).postImage!), fit: BoxFit.cover, ),
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: 8,
                            top: 8,
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              onPressed:(){
                                Layout_Cubit.get(context).closePostImage();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed:(){
                        Layout_Cubit.get(context).getPostImage();
                      } ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Image,
                          ),
                          SizedBox(width: 5,),
                          Text('add photo')
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: 'Write Phone or email ',
                        prefixIcon: Icon(IconBroken.Call,color: Colors.teal,size: 30,),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ) ,
                      ),
                      controller: phoneOrEmailController,

                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.place,color: Colors.brown,size: 30
                        ),
                        hintText: 'Write the location',
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ) ,
                      ),
                      controller:placeController,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: 'what is the requirements',
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ) ,
                      ),
                      controller:requirementsController,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        hintText: 'Write your notes',
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ) ,
                      ),
                      controller:notesController,
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        ' The ad\'s job belongs to what category of these ?',
                         style: TextStyle(
                           height: 1.5,
                           fontSize: 22,
                           fontWeight: FontWeight.w700,
                         ),

                         ),
                      ),
                    Center(
                      child: DropdownButtonFormField<String>(
                        elevation: 0,
                        menuMaxHeight: 300.0,
                        isExpanded: true,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           gapPadding:
                           0.0,
                            borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(color: Colors.black,width: 3,),
                         ),
                       ),
                        alignment: AlignmentDirectional.center,
                        value: cubit.selectedItem ,
                        items:
                          cubit.jobCtegory.map((element) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value:element ,
                            child: Text(element,style: TextStyle(fontSize: 16,color:defaultcolor)),
                          )).toList(),
                        onChanged: (item){
                         cubit.changeItem_DropDownMenue(item!);
                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                       onPressed: (){
                         if(mykey.currentState!.validate())
                          {
                            if(Layout_Cubit.get(context).postImage==null)
                              Layout_Cubit.get(context).createPost(
                                descreption: descriptionController.text,
                                requirements: requirementsController.text,
                                place: placeController.text,
                                phoneOrEmail: phoneOrEmailController.text,
                                notes: notesController.text,
                              );
                            else
                              Layout_Cubit.get(context).createPostwithPhoto(
                                descreption: descriptionController.text,
                                requirements: requirementsController.text,
                                place: placeController.text,
                                phoneOrEmail: phoneOrEmailController.text,
                                notes: notesController.text,
                              );
                          }

                       },
                      child: Text('POST NOW',style: TextStyle(fontSize: 20),),
                    ),
                    SizedBox(height: 10,),
                    if(state is LoadingCreatePostState)
                      LinearProgressIndicator(),
                    SizedBox(height: 40),

                  ]
                ),
              ),
            ),
          ),
        );
      } ,
    );
  }
}
