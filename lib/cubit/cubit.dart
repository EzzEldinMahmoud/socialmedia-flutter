
import 'dart:convert';

import 'package:chatapp/cubit/states.dart';
import 'package:chatapp/layout/MainScreen.dart';
import 'package:chatapp/layout/MarketPlace.dart';
import 'package:chatapp/layout/Settings.dart';
import 'package:chatapp/layout/chatscreen.dart';
import 'package:chatapp/layout/createPOST.dart';
import 'package:chatapp/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/local/cachehelper.dart';

class appcubit extends Cubit<appstate> {
  appcubit(appstate initialState) : super(initialState);
  static appcubit get(context) => BlocProvider.of(context);
  String token = StorageUtil.getString('token');



//get example
  Future gethome({required String }) async {
    emit(apploadingstate());

  }


  //post example
  Future login({required String email , required String password }) async {
    emit(appLOGINloadingstate());
FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
  emit(appLOGINsuccessstate(value.user!.uid));
  print(value.user!);
  print(value.user!.uid);
    }).catchError((onError){
      emit(appLOGINerrorstate(onError.toString()));
    }
    );
  }
//register auth user
  Future register({required String email , required String password,required String username,required String phone  }) async {
    emit(appREGISTERloadingstate());
FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
  emit(appREGISTERsuccessstate());
  Createuser(email: email, password: password, username: username, phone: phone, uid: value.user!.uid).then((value) => {

    print(value)
  }).catchError((e){
    print(e.toString());
  });
  print(value.user!);
  print(value.user!.uid);

}).catchError((e){
  emit(appREGISTERerrorstate('SIGN UP FAILED TRY AAIN LATER'));
});

  }
// create user after register is done
  Future Createuser({required String email , required String password,required String username,required String phone ,required String uid }) async {
    emit(appCREATEUSERloadingstate());
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: username,
      uId: uid,
      image: 'https://rb.gy/de17bo', bio: '',
    );



      FirebaseFirestore.instance.collection('users').doc(uid).set(
        model.toMap(),
      ).then((value) {
        emit(appCREATEUSERsuccessstate());
      }).catchError((e){
        emit(appCREATEUSERerrorstate('E-mail is used'));
      });



  }

}