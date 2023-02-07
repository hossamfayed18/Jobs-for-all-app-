import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';

class Edit_Profile_Screen extends StatelessWidget {
  var nameController =TextEditingController();
  var bioController =TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Layout_Cubit,LayoutStates>(
      listener: (context,state){},
      builder:  (context,state){
        var cubit =Layout_Cubit.get(context);
        var profileImage =cubit.profileImage;
        var coverImage =cubit.coverImage;
        var model = cubit.userModel ;
        nameController.text= model!.name!;
        bioController.text= model.bio!;
        phoneController.text= model.phone!;
        return Scaffold(
          appBar:defualtAppBar(
            context: context,
            title: 'Edit Profile',
          ) ,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 227,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 155,
                                decoration: BoxDecoration(
                                  image:coverImage==null? DecorationImage(image:ExtendedNetworkImageProvider(model.cover!), fit: BoxFit.cover,):DecorationImage(image:FileImage(coverImage), fit: BoxFit.cover, ),
                                  borderRadius: BorderRadius.only(
                                    topRight:Radius.circular(5) ,
                                    topLeft:Radius.circular(5) ,
                                  ),
                                ),
                              ),
                              if(coverImage!=null&& cubit.showbottom==true)
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ElevatedButton(
                                    onPressed:(){
                                      cubit.uploadCoverImage();
                                    },
                                    child: Text(
                                      'Update ',
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  end: 8,
                                  top: 8,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey
                                  ,
                                  radius: 20,
                                  child: IconButton(
                                    onPressed:(){
                                      cubit.getCoverImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 67,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: profileImage==null? CircleAvatar(backgroundImage:  ExtendedNetworkImageProvider(model.image!,), radius: 65,):CircleAvatar(backgroundImage:  FileImage(profileImage), radius: 65,),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 19,
                              child: IconButton(
                                onPressed:(){
                                  cubit.getProfileImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if(profileImage!=null && cubit.showbottom2==true)
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: 40
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: (){
                                  cubit.uploadProfileImage();
                                },

                                child: Text(
                                  'update ',
                                   style: TextStyle(
                                   ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 55,),
                  defaultTFF(
                    mycontroller: nameController,
                    mykeyboardType: TextInputType.text, text: 'Name',
                    myprefixIcon:  IconBroken.User ,
                  ),
                  SizedBox(height:10),
                  defaultTFF(
                    mycontroller: bioController,
                    mykeyboardType: TextInputType.text,
                    text: 'Bio',
                    myprefixIcon: IconBroken.Info_Circle,
                  ),
                  SizedBox(height:10),
                  defaultTFF(
                    mycontroller: phoneController,
                    mykeyboardType: TextInputType.phone,
                    text: 'Phone',
                    myprefixIcon: IconBroken.Call,
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: (){
                        cubit.updateUserProfil(
                          name: nameController.text,
                          email: model.email,
                          phone: phoneController.text,
                          uid: model.uid,
                          image: model.image,
                          cover: model.cover,
                          bio: bioController.text,
                        );
                      },
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          fontSize: 22,
                        ),

                      ),
                  ),
                ],
              ),
            ),
          ),

        );
      } ,
    );
  }
}
