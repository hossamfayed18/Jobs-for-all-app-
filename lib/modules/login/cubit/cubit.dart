import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/layout/Layout_screen.dart';
import 'package:jobs_for_all/layout/cubit/cubit.dart';
import 'package:jobs_for_all/modules/login/cubit/states.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/network/cache_helper.dart';

import '../../../shared/components/constants.dart';

class Login_Cubit extends Cubit<LoginStates>{
  Login_Cubit(): super(LoginInitialState());

  static Login_Cubit get(context){
    return BlocProvider.of(context);
  }


  bool ispass =true ;
  IconData myicon= Icons.remove_red_eye_outlined;
  void chngePasswordVisibility (){
    ispass=!ispass;
    ispass?myicon=Icons.remove_red_eye_outlined :myicon=Icons.visibility_off;
    emit(changeIconState());
  }

  void Login({required String email ,required String password,context}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      uid =value.user!.uid;
      showToastMessage(
        text:'login success' ,
        state: ToastState.Success,
      );
      CacheHelper.sharedPreferences!.setString('uid',value.user!.uid).then((value){

          Layout_Cubit.get(context).getUser();
          Layout_Cubit.get(context).getMyPosts();
          Layout_Cubit.get(context).getChats();
        emit(LoginSuccessState());
        navigateAndFinish(context, Layout_Screen());
      });
    }).catchError((error){
      showToastMessage(
        text:'login failed' ,
        state: ToastState.Error,
      );
      print(error);
      emit(LoginErrorState());
    });
  }

}