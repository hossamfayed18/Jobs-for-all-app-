import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobs_for_all/layout/cubit/states.dart';
import 'package:jobs_for_all/models/message_model.dart';
import 'package:jobs_for_all/models/post_model.dart';
import 'package:jobs_for_all/models/userModel.dart';
import 'package:jobs_for_all/modules/chats_screen/chats_screen.dart';
import 'package:jobs_for_all/modules/home_screen/home_screen.dart';
import 'package:jobs_for_all/modules/others_profile/others_profile.dart';
import 'package:jobs_for_all/modules/settings_screen/settings_screen.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/components/constants.dart';


class  Layout_Cubit extends Cubit<LayoutStates> {
  Layout_Cubit() :super(LayoutInitialState());


  static Layout_Cubit get(context) {
    return BlocProvider.of(context);
  }


  List<Widget> screens = [
    Home_Screen(),
    Chats_Screen(),
    Chats_Screen(), //تمويه
    Settings_Screen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'null',
    'Settings',
  ];

  int current_index = 0;

  void changeBottomNavIndex(int ind) {
    if (ind == 2)
      emit(AddNewPostState());
    else {
      current_index = ind;
      emit(LayoutChangeBottomNavIndexState());
    }
  }


 List<String> jobCtegory =[
   'engineering jobs',
   'Information technology jobs',
   'education sector jobs' ,
   'Journalism,media and television jobs',
   'Management, business and accounting',
   "Medical sector jobs",
   "Freelance and remote work jobs",
   "Tourism and hotel jobs",
    "law jobs",
   "Translation, languages and publishing",
    'others',
 ] ;

String selectedItem = 'engineering jobs';


void changeItem_DropDownMenue(String item)
{
  selectedItem=item;
  emit(ChangeItemDropDownMenue());
}

  UserModel ? userModel;

  void getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid!).get().then((value) {
      userModel = UserModel.Fromjson(value.data()!);
      emit(GetUserSuccssState());
    }).catchError((error) {
      print(error);
      emit(GetUserErrorState());
    });
  }

File ? postImage ;
var postImagePicker =ImagePicker();





  Future<void> getPostImage() async {
    final pickedFile =
    await postImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
    emit(GetPostImageSuccessState())  ;
    }
    else {
      print('No image selected');
      emit(GetPostImageErrorState())  ;
    }
  }




  void createPost({
  required String descreption ,
    String ? Image ,
    String ? notes ,
    String ? phoneOrEmail ,
    String ? place ,
    String ? requirements,
  })
  {
    emit(LoadingCreatePostState());
    var now = DateTime.now();
    PostModel model= PostModel(
    dateTime: now.toString().substring(0,16),
     profileImage: userModel!.image,
     image: Image ??'',
      uid: userModel!.uid,
      name: userModel!.name,
      description: descreption,
      jobCategory: selectedItem,
      notes: notes??'',
      phoneOrEmail: phoneOrEmail??'',
      place: place??'' ,
      requirements: requirements??'' ,
    );
    FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((value){

      FirebaseFirestore.instance.collection(selectedItem).add(model.toMap()).then((value){

        FirebaseFirestore.instance.collection('users').doc(userModel!.uid).collection('posts').add(model.toMap()).then((value){
          showToastMessage(
            text: 'posted success',
            state: ToastState.Success
          ) ;
          closePostImage();
          getAllPosts();
          getMyPosts();


          emit(CreatePostSuccessState());

        }).catchError((error){ emit(CreatePostErrorState());});




      }).catchError((error){ emit(CreatePostErrorState());});


    }).catchError((error){
      emit(CreatePostErrorState());
    });

  }








  void createPostwithPhoto({
    required String descreption ,
    String ? notes ,
    String ? phoneOrEmail ,
    String ? place ,
    String ? requirements,
  }){
   emit(LoadingCreatePostState()) ;
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        final now = DateTime.now();
        createPost(
          descreption: descreption,
          notes: notes,
          phoneOrEmail: phoneOrEmail,
          place: place,
          requirements: requirements,
          Image: value,
        );
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    })
        .catchError((error) {
      emit(CreatePostErrorState());
    });

  }

  void closePostImage(){

    postImage=null;
    emit(closePostImageState());
  }


  final profilePicker = ImagePicker();
  final coverpicker = ImagePicker();
  File ? profileImage;
  File ? coverImage;
  Future<void> getProfileImage() async {
    final pickedFile =
    await profilePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      // print(profileImage!.path);
      show2();
      emit(ProfileImagePickerSuccessState());
    }
    else {
      print('No image selected');
      emit(ProfileImagePickerErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile =
    await coverpicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      show();
      emit(CoverImagePickerSuccessState());
    }
    else {
      print('No image selected');
      emit(CoverImagePickerErrorState());
    }
  }




  void uploadProfileImage(){

    emit(LoadingProfileImageState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserProfil(
          name: userModel!.name,
          email: userModel!.email,
          phone: userModel!.phone,
          uid: userModel!.uid,
          image: value,
          cover: userModel!.cover,
          bio: userModel!.bio,
        );
        emit(UploadProfileImageSuccessState());
        show2();
        showToastMessage(text: 'profile image uploaded success', state:ToastState.Success);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    })
        .catchError((error) {
      print(error);
    });

  }


  void uploadCoverImage(){
    emit(LoadingCoverImageState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserProfil(
          name: userModel!.name,
          email: userModel!.email,
          phone: userModel!.phone,
          uid: userModel!.uid,
          image: userModel!.image,
          cover: value,
          bio: userModel!.bio,
        );
        emit(UploadCoverImageSuccessState());
        show();
        showToastMessage(text: 'Cover image uploaded success', state:ToastState.Success);
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    })
        .catchError((error) {
      print(error);
      print('zzzzzzzzzzz');
    });

  }


  void updateUserProfil({
    required  String ?name ,
    required  String ?email ,
    required  String ?phone ,
    required  String ? uid ,
    required  String ? image ,
    required  String ? cover ,
    required  String ? bio ,
  })

  {
    var  model= UserModel(
      cover: cover,
      image: image,
      bio: bio,
      uid: uid,
      name:name ,
      phone:phone ,
      email: email,
    );
    FirebaseFirestore.instance.collection('users').doc(uid).update(model.toMap()).then((value){
      getUser();
      emit(UpdateProfileSuccessState());
    }).catchError((error){
      emit(UpdateProfileErrorState());
    });



  }


  bool showbottom=false ;

  void show (){
    showbottom=!showbottom;
    emit(UpdateProfileSuccessState());
  }

 bool showbottom2=false;
  void show2 (){
    showbottom2=!showbottom2;
    emit(UpdateProfileSuccessState());
  }


   List<PostModel> myposts =[];
  // List<PostModel> engineeringPosts =[];
  // List<PostModel> technologyPosts =[];
  // List<PostModel> educationPosts =[];
  // List<PostModel> JournalismPosts =[];
  // List<PostModel> ManagementPosts =[];
  // List<PostModel> MedicalPosts =[];
  // List<PostModel> FreelancePosts =[];
  // List<PostModel> TourismPosts =[];
  // List<PostModel> lawPosts =[];
  // List<PostModel> TranslationPosts =[];
  // List<PostModel> othersPosts =[];

  List<PostModel> mylist =[];

  void getAllPosts (){

    emit(LoadingGetAllPostsState());
    mylist=[];
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
          mylist.add(PostModel.Fromjson(element.data()));
        });
      emit(GetAllPostsSuccessState());
    }).catchError((error){
      emit(GetAllPostsErrorState());
    });
  }

  void getMyPosts (){
    myposts=[];
    emit(LoadingGetMyPostsState());
    FirebaseFirestore.instance.collection('users').doc(uid).collection('posts').get().then((value){
      value.docs.forEach((element) {
        myposts.add(PostModel.Fromjson(element.data()));
      });
      emit(GetMyPostsSuccessState());
    }).catchError((error){
      emit(GetMyPostsErrorState());
    });
  }

  void getengineeringPosts (){   //1

    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('engineering jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void gettechnologyPosts (){   //2

    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Information technology jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void geteducationPosts (){   //3

    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('education sector jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void geteJournalismPosts (){   //4

    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Journalism,media and television jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void geteManagementPosts (){   //5
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Management, business and accounting').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void geteMedicalPosts (){   //6
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Medical sector jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }


  void geteFreelancePosts (){   //7
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Freelance and remote work jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void getTourismPosts (){   //8
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Tourism and hotel jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void getlawPosts (){   //9
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('law jobs').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void getTranslationPosts (){   //10
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('Translation, languages and publishing').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  void getothersPosts (){   //11
    mylist=[];
    emit(LoadingGetCatPostsState());
    FirebaseFirestore.instance.collection('others').get().then((value){
      value.docs.forEach((element) {
        mylist.add(PostModel.Fromjson(element.data()));
      });
      emit(GetCatPostsSuccessState());
    }).catchError((error){
      emit(GetCatPostsErrorState());
    });
  }

  bool showMyPosts =false ;
void changeShownMyPosts(){
   showMyPosts = ! showMyPosts ;
   emit(changeShownMyPostsState());

}

 String selectedItem_ = 'all jobs';

  void changeItem_DropDownMenue_(String item)
  {
    selectedItem_=item;
    emit(ChangeItemDropDownMenue());
  }



   UserModel ? otherUserModel ;
  List<PostModel> otherPosts =[];
  void getOtherUser(uid,context){
    emit(GetOtherUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      otherUserModel = UserModel.Fromjson(value.data()!);
      otherPosts = [];

      FirebaseFirestore.instance.collection('users').doc(uid)
          .collection('posts')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          otherPosts.add(PostModel.Fromjson(element.data()));
        });
        emit(GetOtherUserSuccssState());
      }).catchError((error) {
      });

      emit(GetOtherUserSuccssState());
      navigatorTo(context, Others_Profile_Screen());
    }).catchError((error) {
      print(error);
      emit(GetOtherUserErrorState());
    });
  }

List<UserModel> chatsList =[] ;

  void addUserTOChats (){
   emit(LoadingAddOtherToChatState());
    FirebaseFirestore.instance.collection('users').doc(uid).collection('chats').doc(otherUserModel!.uid).set(otherUserModel!.toMap()).then((value){

      FirebaseFirestore.instance.collection('users').doc(otherUserModel!.uid).collection('chats').doc(uid).set(userModel!.toMap()).then((value){
        showToastMessage(text: 'added success', state: ToastState.Success);
        getChats();
        emit(AddOtherToChatSuccessState());
      }).catchError((error){
        emit(AddOtherToChatErrorState());
      });


    }).catchError((error){
      emit(AddOtherToChatErrorState());
    });

  }

 void getChats (){
   chatsList=[];
   emit(LoadingGetChatstState());
   FirebaseFirestore.instance.collection('users').doc(uid).collection('chats').get().then((value){
     value.docs.forEach((element) {
       chatsList.add(UserModel.Fromjson(element.data()));
     });
     emit(GetChatsSuccessState());
   }).catchError((error){
     emit(GetChatsErrorState());
   });

 }


  void sendMessage ({required String  text, required String dateTime ,required String recieverId}){
    MessageModel model = MessageModel(
      dateTime: dateTime,
      text: text,
      recieverId: recieverId,
      senderId:userModel!.uid ,

    );

    FirebaseFirestore.instance.collection('users').doc(userModel!.uid).collection('chats').doc(recieverId).collection('messages').add(model.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users').doc(recieverId).collection('chats').doc(userModel!.uid).collection('messages').add(model.toMap()).then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });

  }


  List<MessageModel>messages =[];

  void getMessages (String recieverUid){
    FirebaseFirestore.instance.collection('users').doc(userModel!.uid).collection('chats').doc(recieverUid).collection('messages').orderBy('dateTime')
        .snapshots().listen((event) {
      messages =[] ;
      event.docs.forEach((element) {
        messages.add(MessageModel.Fromjson(element.data()));
        emit(GetMessagesSuccessState());
      });
    });

  }




}