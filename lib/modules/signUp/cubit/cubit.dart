import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/models/userModel.dart';
import 'package:jobs_for_all/modules/signUp/cubit/states.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/network/cache_helper.dart';

class SignUp_Cubit extends Cubit<SignUpStates>{
  SignUp_Cubit(): super(SignUpInitialState());

  static SignUp_Cubit get(BuildContext context){
    return BlocProvider.of(context);
  }


  bool ispass =true ;
  IconData myicon= Icons.remove_red_eye_outlined;
  void chngePasswordVisibility (){
    ispass=!ispass;
    ispass?myicon=Icons.remove_red_eye_outlined :myicon=Icons.visibility_off;
    emit(SignUpChangePasswordVisibility());
  }

  void userRegister({required String email,required String password,required String name,required String phone}) {
    emit(SignUpLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      createUser(
          email: email,
          phone: phone,
          name: name,
          uid: value.user!.uid
      );

    }).catchError((error) {
      print(error);
      emit(SignUperrorState(error: error.toString()));
    });
  }

  void createUser({required String email,required String name,required String phone,required String uid}){
    UserModel model = UserModel(
      name:name ,
      phone: phone,
      email: email,
      uid: uid,
      image: 'https://firebasestorage.googleapis.com/v0/b/jobs-for-all-a8bf5.appspot.com/o/Screenshot%202022-12-24%20185125%20(1).png?alt=media&token=7905ad49-bb2c-4179-90fd-ae8bf0d63ab6',
      bio: 'hey everyone..',
      cover:'https://firebasestorage.googleapis.com/v0/b/jobs-for-all-a8bf5.appspot.com/o/hhhh.jpg?alt=media&token=1630c3e4-82ff-42ec-848c-18acf46b64d2',
    );
    emit(CreateUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value){
      emit(CreateUserSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(CreateUsererrorState(error: error.toString()));
    }
    );


  }




}