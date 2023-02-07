import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/models/post_model.dart';
import 'package:jobs_for_all/modules/others_profile/others_profile.dart';
import 'package:jobs_for_all/modules/settings_screen/settings_screen.dart';
import 'package:jobs_for_all/shared/style/icon_broken.dart';

import 'constants.dart';

Widget defaultButton (
    {
      Color mycolor = Colors.blue,
      String text = 'Login',
      double myheight = 50,
      double mywidth = double.infinity,
      bool isupercase = true  ,
      required  Function() function ,
    }
    )

=>  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 0),
  child:   Container(

    width:mywidth,

    height: myheight,

    color: mycolor,

    child: MaterialButton(


      child:Text(

        isupercase ? text.toUpperCase() : text ,

        style: TextStyle(

          fontSize: 28,

          color: Colors.white,

        ),

      ),

      onPressed: function ,



    ),



  ),
) ;





Widget defaultTFF (
    {
      required TextEditingController ? mycontroller ,
      required TextInputType ? mykeyboardType ,
      required   String ? text ,
      required  IconData ? myprefixIcon   ,
      IconData ?  mysuffixIcon ,
      bool ispass = false ,
      Function (String value) ? onsubmitedfunction  ,
      Function (String x)  ?  onChangedfunction ,
      FormFieldValidator<String>? validatorfunction ,
      Function() ? suffixiconfun ,
      Function() ? ontapfun ,

    }
    )

=>   TextFormField(
  controller: mycontroller ,
  validator: validatorfunction ,
  onFieldSubmitted: onsubmitedfunction,
  onChanged: onChangedfunction,
  obscureText: ispass,
  keyboardType:mykeyboardType ,
  onTap: ontapfun,
  decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(),
      prefixIcon: Icon(
          myprefixIcon
      ),
      suffixIcon: IconButton(
        icon: Icon(mysuffixIcon),
        onPressed:  suffixiconfun ,
      )
  ),

) ;




Widget mydivider ()=>Padding(
  padding: EdgeInsetsDirectional.only(
      start: 10
  ),
  child:   Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    height: 1,
    width: double.infinity,
    color: Colors.grey,
  ),
);



void navigatorTo(context,Widget widget){
  Navigator.push(context,MaterialPageRoute(
      builder:  (context){return widget;}
  ));
}

void navigateAndFinish(context,Widget widget){
  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
      builder:(context){return widget;}
  ),(route) {
    return false;
  },);
}

void showToastMessage({
  required String text,
  required ToastState state ,
}){

  Fluttertoast.showToast(
    msg:text ,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: setToastColor(state),
    textColor:Colors.white,
    fontSize: 16.0,
  );
}

enum ToastState {Success,Error,Warning}

Color setToastColor (ToastState state){
  Color color = Colors.red ;
  switch(state) {
    case ToastState.Success:
      color= Colors.green;
      break;
    case ToastState.Error:
      color= Colors.red;
      break;
    case ToastState.Warning:
      color= Colors.amber;
      break;
  }
  return color ;

}



PreferredSizeWidget defualtAppBar ({
  required BuildContext context ,
  String ? title,
  List<Widget>? actions ,
}) {
  return AppBar(
    title: title != null ? Text(
      title ?? '',

    ) : null,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        IconBroken.Arrow___Left_2,
      ),
    ),
    actions: actions != null ? actions : null,
    //titleSpacing: 5.0,

  );
}


Widget buildPost(context,PostModel model,bool ismypost){
  return Card(
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Padding(
      padding:  EdgeInsetsDirectional.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if(ismypost)
                CircleAvatar(
                  radius: 20,
                  backgroundImage: ExtendedNetworkImageProvider(
                    model.profileImage!,
                  ),
                ),
              if(!ismypost)
              InkWell(
                onTap: (){
                  if(model.uid!=uid)
                    Layout_Cubit.get(context).getOtherUser(model.uid,context);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: ExtendedNetworkImageProvider(
                    model.profileImage!,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(ismypost)
                      Text(
                        model.name!,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    if(!ismypost)
                    InkWell(
                      onTap: (){
                        if(model.uid!=uid)
                         Layout_Cubit.get(context).getOtherUser(model.uid,context);
                      },
                      child: Text(
                        model.name!,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                        model.dateTime!,
                        style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey,)
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.more_horiz ,
                  size: 16,
                ) ,
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(
            model.description!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
              height: 1.3,
            ),
          ),
          SizedBox(height: 10,),
          if(model.image=='')
          Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: 10
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          if(model.image !='')
            Column(
              children: [
                Padding(
                  padding:const EdgeInsetsDirectional.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: ExtendedNetworkImageProvider(
                              model.image!,
                            )

                        ),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      bottom: 10
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          if(model.phoneOrEmail !='')
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.send_to_mobile,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'For communication :',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),

                  ),
                ],
              ),
              SizedBox(height:3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(model.phoneOrEmail!,style:Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 16,
                    color: Colors.blue
                ),),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 10,
                  top: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          if(model.place !='')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'The location :',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),

                  ),
                ],
              ),
              SizedBox(height:3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(model.place!,style:Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 16,
                    color: Colors.blue
                ),),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 10,
                  top: 10 ,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          if(model.requirements !='')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.list_outlined,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'The requirements :',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),

                  ),
                ],
              ),
              SizedBox(height:3),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(model.requirements!,style:Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16,
                        color: Colors.blue
                    ),),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 10,
                  top: 10 ,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          if(model.notes !='')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_note_sharp,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'Notes :',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),

                  ),
                ],
              ),
              SizedBox(height:3),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(model.notes!,style:Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16,
                        color: Colors.blue
                    ),),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 10,
                  top: 10 ,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),

        ],
      ),
    ),

  );
}




