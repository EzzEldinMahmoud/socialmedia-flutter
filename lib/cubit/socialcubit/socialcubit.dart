import 'dart:convert';
import 'dart:io';

import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/layout/Profile/profile_screen.dart';
import 'package:chatapp/layout/chat_screen/chat_screen.dart';
import 'package:chatapp/layout/create_post/create_post_screen.dart';
import 'package:chatapp/layout/market_place/market_place_screen.dart';
import 'package:chatapp/models/comment_model.dart';
import 'package:chatapp/models/post_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/shared/remote/diohelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../layout/home_screen_folder/home_screen.dart';
import '../../models/message_model.dart';
import '../../models/singlepost.dart';
import '../../shared/local/cachehelper.dart';

class Socialappcubit extends Cubit<socialappstate> {
  Socialappcubit(socialappstate initialState) : super(initialState);
  static Socialappcubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;
//...........................................................................................
//GET ALL USERS
  List<UserModel> users = [];
  void getusers() {
    emit(SocialappGETALLUSERloadingstate());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != StorageUtil.getString('uId')) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialappGETALLUSERsuccessstate(users));
    }).catchError((e) {
      emit(SocialappGETALLUSERERRORstate(e.toString()));
    });
  }
//...........................................................................................
//get user data
  void getUserData() {
    emit(SocialappGETUSERloadingstate());
    var uid = StorageUtil.getString('uid');
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      usermodel = UserModel.fromJson(value.data()!);
      StorageUtil.putString('name', usermodel!.name!);
      StorageUtil.putString('uId', usermodel!.uId!);
      StorageUtil.putString('image', usermodel!.image!);
      StorageUtil.putString('email', usermodel!.email!);

      emit(SocialappGETUSERsuccessstate(usermodel));
    }).catchError((e) {
      emit(SocialappGETUSERERRORstate(e.toString()));
    });
  }
//...........................................................................................
  //get all posts
  List<PostModel> posts = [];
  List<String> postsid = [];
  List<int> likes = [];
  bool liked = false;
  List<CommentModel> comments = [];
//...........................................................................................
//get comments
  void getcomments({required String? postid}) {
    emit(SocialappGETCOMMENTSSLOADINGstate());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .get()
        .then((value) {
      comments = [];
      for (var element in value.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }

      emit(SocialappGETCOMMENTSSuccessstate(comments));
    }).catchError((e) {
      emit(SocialappGETCOMMENTSSERRORstate(e.toString()));
    });
  }
  //...........................................................................................
  //send reset password links
  void resetPassword({required String email}){
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => {
      emit(SocialappSendResetEmailSuccessState())
    }).catchError((e){
      emit(SocialappSendResetEmailerrorstate(e.toString()));
      return e;
    });
  }
  //...........................................................................................
  //send  Reports
  void sendReport({
    required String username,
    required String userEmail,
    required String text,
    required String problemId,
    required String problemTitle,
    required String userId
  }){
    String service_id = "service_h9vrh1p";
    String template_id = "template_6pg3266";
    String user_id= "GkXg11axyk3Ers9JG";
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    diohelper.postData(Url: url.toString(), data: {
      'service_id':service_id,
      'template_id':template_id,
      'user_id':user_id,
      'template_params':{
        'user_name':username,
        "user_email":userEmail,
        'problem_id':problemId,
        'problem_title':problemTitle,
        'user_id':userId,
        'text':text,
        'app_name':"CloseWorld"
      }
    }).then((value) => {
    emit(SocialappSendEmailSuccessState())
    }).catchError((e){
      emit(SocialappSendEmailerrorstate(e.toString()));
      return e;
    });
  }
//...........................................................................................
  //get posts
  void getPosts() {
    emit(SocialappGETPOSTSLOADINGstate());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsid.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialappGETPOSTSSuccessstate(posts));
        }).catchError((e) {
          emit(SocialappGETPOSTSERRORstate(e.toString()));
        });
      }
    }).catchError((e) {
      emit(SocialappGETPOSTSERRORstate(e.toString()));
    });
  }
//...........................................................................................
//remove post image
  void removepostimage() {
    postimagehere = null;
    emit(SocialappRemovePostImagestate());
  }
//...........................................................................................
  //get profileimage
  File? profileImage;
  ImagePicker picker = ImagePicker();
  Future getProfileImage(BuildContext context) async {
    emit(SocialappGETPROFILEIMAGELOADINGstate());
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialappGETPROFILEIMAGESuccessstate());
    } else {
      emit(SocialappGETPROFILEIMAGEERRORstate('no image selected'));
    }
  }
//...........................................................................................
  //upload profile image
  String profileimageurl = '';
  void uploadprofileImage({
    required String name,
    required String phone,
    required String bio,
    String? image,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
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
      }).catchError((e) {
        emit(SocialappUPLOADPROFILEIMAGEERRORstate(e.toString()));
      });
    }).catchError((e) {
      emit(SocialappUPLOADPROFILEIMAGEERRORstate(e.toString()));
    });
  }
//...........................................................................................
//create post
  String? postimagehere;
  ImagePicker postpicker = ImagePicker();
  Future getpostImage(BuildContext context) async {
    emit(SocialappGETPostIMAGELOADINGstate());
    XFile? pickedFile = await postpicker.pickImage(source: ImageSource.gallery);

    final bytes = File(pickedFile!.path).readAsBytesSync();
    String base64Image =  base64Encode(bytes);
    postimagehere = base64Image;
    //postimagehere = File(pickedFile.path);
    emit(SocialappGETPostIIMAGESuccessstate());
    }
  //...........................................................................................
//upload post image
/*  void uploadPostImage({
    required String datetime,
    required String text,
  }) {
    emit(SocialappCreatePostImageLOADINGstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postimagehere!.path).pathSegments.last}')
        .putFile(postimagehere!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialappCreatePostImageSuccessstate());

        createpost(datetime: datetime, text: text, postimage: value);
        return value;
      }).catchError((e) {
        emit(SocialappCreatePostImageERRORstate(e.toString()));
        return e.toString();
      });
    }).catchError((e) {
      emit(SocialappCreatePostImageERRORstate(e.toString()));
    });

  }*/
  //...........................................................................................
//create post
  void createpost({
    required String datetime,
    required String? postimage,
    required String text,
  }) {
    emit(SocialappCreatePostloadingstate());
    PostModel postmodel = PostModel(
        name: usermodel?.name,
        datetime: datetime,
        postimage: postimage ?? ' ',
        uId: usermodel?.uId,
        image: usermodel?.image,
        text: text, bio:  usermodel?.bio);
    FirebaseFirestore.instance
        .collection('posts')
        .add(postmodel.toMap())
        .then((value) {
      emit(SocialappCreatePostsuccessstate());
    }).catchError((e) {
      emit(SocialappCreatePostERRORstate(e.toString()));
    });
  }
//...........................................................................................
  // update user data
  void updateuserdata({
    required String? name,
    required String? phone,
    required String? bio,
    String? image,
  }) {
    UserModel? model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: usermodel?.email,
      uId: usermodel?.uId,
      image: image ?? usermodel?.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      emit(SocialappUPDATEUSERsuccessstate());
      getUserData();
    }).catchError((e) {
      emit(SocialappUPDATEUSERERRORstate(e.toString()));
    });
  }
//...........................................................................................
  // like post
  void likepost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(usermodel?.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialappLIKEPOSTsuccessstate());
    }).catchError((e) {
      emit(SocialappLIKEPOSTERRORstate(e.toString()));
    });
  }
//get comments
//...........................................................................................
//create comment
  void createcomment({
    required String? datetime,
    required String? text,
    required String? postid,
  }) {
    emit(SocialappCREATECOMMENTloadingstate());
    String name = StorageUtil.getString('name');
    String uId = StorageUtil.getString('uId');
    String image = StorageUtil.getString('image');

    CommentModel commencement = CommentModel(
        name: name, datetime: datetime, uId: uId, image: image, text: text);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .doc(usermodel?.uId)
        .set(commencement.toMap())
        .then((value) {
      emit(SocialappCREATECOMMENTsuccessstate());
    }).catchError((e) {
      emit(SocialappCREATECOMMENTERRORstate(e.toString()));
    });
  }
  List userposts = [];
  //...........................................................................................
  var uid = StorageUtil.getString('uid');
//get user posts
  void getuserposts(){
    emit(SocialappUSERPOSTSinitialstate());
    var uid = StorageUtil.getString('uid');
    FirebaseFirestore.instance.collection('posts').get().then((value) {

        for (var element in value.docs) {

   if(element.data()['uId'] == uid){
     Map<String,String> allpostdata = new Map.from(element.data());
allpostdata['postid']= element.reference.id;
print(allpostdata);
     userposts.add(SinglePost.fromJson(allpostdata));

     emit(SocialappUSERPOSTSsuccessstate(userposts));
   }


        }
    });


  }
  //...........................................................................................


  // chat system function
  List<MessageModel> messages = [];
  void getmessages({required String receiverId}){
    FirebaseFirestore.instance.collection('users').doc(uid).collection('chats').doc(receiverId).collection('messages').orderBy('datetime').snapshots().listen((event) {
      messages = [];
      for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data())) ;
      }
      emit(SocialappGETMessagesSSuccessstate());

    });
  }
  //...........................................................................................
  // Last message function
  late MessageModel lastmessage ;
  void getLastMessages({required String receiverId}){
    FirebaseFirestore.instance.collection('users').doc(uid).collection('chats').doc(receiverId).collection('messages').orderBy('datetime').get().then((value) => {

    lastmessage =  MessageModel.fromJson(value.docs.last.data()),

      emit(SocialappGETLastMessagesSSuccessstate(lastmessage))
    }).catchError((e){
      emit(SocialappGETLastMessagesSERRORstate(e.toString()));
return e;
    });
  }
  //...........................................................................................
//send message
  void sendmessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
}){

    MessageModel model = MessageModel(recieverId: receiverId, datetime: dateTime, senderId: uid, image: image, text: text);
    // set user chat
    FirebaseFirestore.instance.collection('users').doc(uid).collection('chats').doc(receiverId).collection('messages').add(
      model.toMap()
    ).then((value)  {
      emit(SocialappSENDMessagesSSuccessstate());
    }).catchError((error){
      emit(SocialappSENDMessagesSERRORstate(error.toString()));
    });
    // set reciever chat
    FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(uid).collection('messages').add(
        model.toMap()
    ).then((value)  {
      emit(SocialappSENDMessagesSSuccessstate());
    }).catchError((error){
      emit(SocialappSENDMessagesSERRORstate(error.toString()));
    });
  }
//...........................................................................................


  // delete post
  void deleteMyPost({required String postid}) async{
    try{
      FirebaseFirestore.instance.collection('posts').doc(postid).delete();
      emit(SocialappDeletePostSuccessstate());
    }catch(e){
      emit(SocialappDeletePostERRORstate(e.toString()));
    }

  }
  //...........................................................................................

  //to do:
  // Edit post
  void editMyPost({required String postid,required String postimage,required String text}) async{

    try{
      FirebaseFirestore.instance.collection('posts').doc(postid).update({
"postimage": "${postimage}","text": "${text}"
          }).then((value) => {

      emit(SocialappEditUserPostSuccessstate())
      }).catchError((e){
        emit(SocialappEditUserPostSERRORstate(e.toString()));

      });

    }catch(e){
      emit(SocialappEditUserPostSERRORstate(e.toString()));
    }

  }

//...........................................................................................
//bottom nav bar
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
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
    const Homescreen(),
    const CHATSCREEN(),
    const CREATEPOST(),
    const MarketPlace(),
    const Settingscreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Create Post',
    'Market Place',
    'Settings',
  ];

  void changeindex(int index) {
    currentindex = index;
    emit(Socialappbottomnavstate());
  }
}
