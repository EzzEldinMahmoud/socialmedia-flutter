
import 'dart:convert';
import 'dart:io';

import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/layout/Homescreen.dart';
import 'package:chatapp/layout/MarketPlace.dart';
import 'package:chatapp/layout/Settings.dart';
import 'package:chatapp/layout/chatscreen.dart';
import 'package:chatapp/layout/createPOST.dart';
import 'package:chatapp/models/Commentmodel.dart';
import 'package:chatapp/models/Postmodel.dart';
import 'package:chatapp/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../shared/local/cachehelper.dart';

class Socialappcubit extends Cubit<socialappstate> {
  Socialappcubit(socialappstate initialState) : super(initialState);
  static Socialappcubit get(context) => BlocProvider.of(context);

UserModel? usermodel;

//GET ALL USERS
  List <UserModel> users = [];
  void getusers(){
    emit(SocialappGETALLUSERloadingstate());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if(element.data()['uId'] != StorageUtil.getString('uId')){
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialappGETALLUSERsuccessstate(users));
    }).catchError((e){
      emit(SocialappGETALLUSERERRORstate(e.toString()));
    });

  }

//get user data
  void getUserData(){
emit(SocialappGETUSERloadingstate());
var uid = StorageUtil.getString('uid');
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      usermodel = UserModel.fromJson(value.data()!);
      StorageUtil.putString('name', usermodel!.name!);
      StorageUtil.putString('uId', usermodel!.uId!);
      StorageUtil.putString('image', usermodel!.image!);

      emit(SocialappGETUSERsuccessstate(usermodel));
    }).catchError((e){
      emit(SocialappGETUSERERRORstate(e.toString()));
    });
  }
  //get all posts
  List <PostModel> posts = [];
  List <String> postsid = [];
  List<int> likes= [];
  bool liked = false;
  List <CommentModel> comments = [];

//get comments
  void getcomments({required String postid}){

    emit(SocialappGETCOMMENTSSLOADINGstate());

    FirebaseFirestore.instance.collection('posts').doc(postid).collection('comments').get().then((value) {
      comments = [];
      for (var element in value.docs) {
        comments.add( CommentModel.fromJson(element.data()));

      }

      emit(SocialappGETCOMMENTSSuccessstate(comments));

    }).catchError((e){
      emit(SocialappGETCOMMENTSSERRORstate(e.toString()));
    });
  }
  //get posts
  void getPosts(){
    emit(SocialappGETPOSTSLOADINGstate());
    var uid = StorageUtil.getString('uid');
    FirebaseFirestore.instance.collection('posts').get().then((value) {

     for (var element in value.docs) {
element.reference.collection('likes').get().then((value) {
  likes.add(value.docs.length);
  postsid.add(element.id);
  posts.add(PostModel.fromJson(element.data()));
  emit(SocialappGETPOSTSSuccessstate(posts));

}).catchError((e){
  emit(SocialappGETPOSTSERRORstate(e.toString()));
});

     }



    }).catchError((e){
      emit(SocialappGETPOSTSERRORstate(e.toString()));
    });
  }
  void removepostimage(){
    postimagehere = null;
    emit(SocialappRemovePostImagestate());
  }
  //get profileimage
  File? profileImage;
  ImagePicker  picker =ImagePicker();
  Future getProfileImage(BuildContext context)async{
    emit(SocialappGETPROFILEIMAGELOADINGstate());
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(SocialappGETPROFILEIMAGESuccessstate());
    }else{
      print('no image selected');
      emit(SocialappGETPROFILEIMAGEERRORstate('no image selected'));
    }
  }

  //upload profile image
  String profileimageurl ='';
void uploadprofileImage({
  required String name,
  required String phone,
  required String bio,
  String? image ,
}){
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}').putFile(profileImage!).then((value) {
      emit(SocialappUPLOADPROFILEIMAGELOADINGstate());
      value.ref.getDownloadURL().then((value) {
     emit(SocialappUPLOADPROFILEIMAGESuccessstate());
      profileimageurl = value;
     updateuserdata(
        name: name,
        phone: phone,
        bio: bio,
        image: profileimageurl,
     );
      }).catchError((e){
        emit(SocialappUPLOADPROFILEIMAGEERRORstate(e.toString()));
      });
    }).catchError((e){
      emit(SocialappUPLOADPROFILEIMAGEERRORstate(e.toString()));
    });

}
//create post
  File? postimagehere;
  ImagePicker  postpicker =ImagePicker();
  Future getpostImage(BuildContext context)async{
    emit(SocialappGETPostIMAGELOADINGstate());
    XFile? pickedFile = await postpicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      postimagehere = File(pickedFile.path);
      emit(SocialappGETPostIIMAGESuccessstate());
    }else{
      print('no image selected');
      emit(SocialappGETPostIIMAGEERRORstate('no image selected'));
    }
  }

  void uploadPostImage({

    required String datetime,


    required String text,

  }){
    emit(SocialappCreatePostImageLOADINGstate());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(postimagehere!.path).pathSegments.last}').putFile(postimagehere!).then((value) {

      value.ref.getDownloadURL().then((value) {
        emit(SocialappCreatePostImageSuccessstate());

       CreatePost(datetime: datetime, text: text, postimage: value);
 return value;
      }).catchError((e){

        emit(SocialappCreatePostImageERRORstate(e.toString()));
      });
    }).catchError((e){

      emit(SocialappCreatePostImageERRORstate(e.toString()));
    });

  }
  void CreatePost({
    required String datetime,
   required  String? postimage,
    required String text,

  }){
    emit(SocialappCreatePostloadingstate());
   PostModel postmodel = PostModel(name: usermodel?.name, datetime: datetime, postimage: postimage?? ' ', uId: usermodel?.uId, image: usermodel?.image, text: text);
   FirebaseFirestore.instance.collection('posts').add(postmodel.toMap()).then((value) {
     emit(SocialappCreatePostsuccessstate());
   }).catchError((e){
     emit(SocialappCreatePostERRORstate(e.toString()));
   });

  }


  // update user data
  void updateuserdata({
    required String? name,
    required String? phone,
    required String? bio,
    String? image ,

  }){
    UserModel? model = UserModel(
      name: name,
      phone: phone,
      bio: bio, email: usermodel?.email , uId: usermodel?.uId, image: image ?? usermodel?.image,

    );
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uId).update(model.toMap()).then((value) {
      emit(SocialappUPDATEUSERsuccessstate());
      getUserData();
    }).catchError((e){
      emit(SocialappUPDATEUSERERRORstate(e.toString()));
    });
  }
  // like post
  void likepost(String postid){
    FirebaseFirestore.instance.collection('posts').doc(postid).collection('likes').doc(usermodel?.uId).set({
      'like':true,
    }).then((value) {
      emit(SocialappLIKEPOSTsuccessstate());
    }).catchError((e){
      emit(SocialappLIKEPOSTERRORstate(e.toString()));
    });
  }
//get comments

//create comment
  void CreateComment({
    required String datetime,
    required String text,
    required String postid,

  }){
    emit(SocialappCREATECOMMENTloadingstate());
String name =  StorageUtil.getString('name');
String uId =  StorageUtil.getString('uId');
String image =  StorageUtil.getString('image');

    CommentModel commencement = CommentModel(name: name, datetime: datetime, uId: uId, image: image, text: text);
    FirebaseFirestore.instance.collection('posts').doc(postid).collection('comments').doc(usermodel?.uId).set(
        commencement.toMap()).then((value) {

      emit(SocialappCREATECOMMENTsuccessstate());
    }).catchError((e){
      emit(SocialappCREATECOMMENTERRORstate(e.toString()));
    });

  }

//bottom nav bar
  int currentindex = 0;
  List<BottomNavigationBarItem>bottomItems=[
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.chat,
      ),
      label: 'Chats',
    ),

    const BottomNavigationBarItem(
      icon: Icon(
        Icons.post_add,
      ),
      label: 'Create Post',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.store_outlined,
      ),
      label: 'Market',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),

  ];
  List<Widget> screens = [
    Homescreen(),
    CHATSCREEN(),
    CREATEPOST(),
    MARKETPLACE(),
    Settingscreen(),
  ];


List <String> titles=[
  'Home',
  'Chats',
  'Create Post',
  'Market Place',
  'Settings',
];




  void changeindex(int index){
    currentindex = index;
    emit(Socialappbottomnavstate());
  }

}