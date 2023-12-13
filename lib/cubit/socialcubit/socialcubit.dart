
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
//get user data
  void getUserData(){
emit(SocialappGETUSERloadingstate());
var uid = StorageUtil.getString('uid');
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      usermodel = UserModel.fromJson(value.data()!);
      emit(SocialappGETUSERsuccessstate());
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

  void getPosts(){
    emit(SocialappGETPOSTSLOADINGstate());
    var uid = StorageUtil.getString('uid');
    FirebaseFirestore.instance.collection('posts').get().then((value) {
     for (var element in value.docs) {
comments.clear();
likes.clear();


          FirebaseFirestore.instance.collection('posts').doc(element.id).collection('likes').get().then((value) {

            FirebaseFirestore.instance.collection('posts').doc(element.id).collection('comments').get().then((value) {



            postsid.add( element.id);
          posts.add( PostModel.fromJson(element.data()));
            likes.add(value.docs.length);
            comments.add(CommentModel.fromJson(element.data()));
            emit(SocialappGETPOSTSSuccessstate());

            });
          }).catchError((e){
            emit(SocialappGETPOSTSERRORstate(e.toString()));
          });

     }
     emit(SocialappGETPOSTSSuccessstate());

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
  void getcomments(String postid){
    emit(SocialappGETCOMMENTSSLOADINGstate());
    comments.clear();
    FirebaseFirestore.instance.collection('posts').doc(postid).collection('comments').get().then((value) {
      for (var element in value.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }
      print(comments.length);
      emit(SocialappGETCOMMENTSSuccessstate());
    }).catchError((e){
      emit(SocialappGETCOMMENTSSERRORstate(e.toString()));
    });
  }
//create comment
  void CreateComment({
    required String name,
    required String datetime,
    required String uId,
    required String image,
    required String text,
    required String postid,

  }){
    emit(SocialappCREATECOMMENTloadingstate());
    CommentModel commentmodel = CommentModel(name: usermodel?.name, datetime: datetime, uId: usermodel?.uId, image: usermodel?.image, text: text);
    FirebaseFirestore.instance.collection('posts').doc(postid).collection('comments').add(
        commentmodel.toMap()).then((value) {

      getcomments(postid);
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