

import 'package:chatapp/cubit/states.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/local/cachehelper.dart';

class appcubit extends Cubit<appstate> {
  appcubit(appstate initialState) : super(initialState);
  static appcubit get(context) => BlocProvider.of(context);
  String token = StorageUtil.getString('token');



//get closeworld
  Future gethome({required String }) async {
    emit(apploadingstate());

  }


  //post closeworld
  Future login({required String email , required String password }) async {
    emit(appLOGINloadingstate());
FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
  emit(appLOGINsuccessstate(value.user!.uid));
    }).catchError((onError){
      emit(appLOGINerrorstate(onError.toString()));
    }
    );
  }
//register auth user
  Future register({required String email , required String password,required String username,required String phone  }) async {
    emit(appREGISTERloadingstate());
FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {

  Createuser(email: email, password: password, username: username, phone: phone, uid: value.user!.uid).then((value) => {
  emit(appREGISTERsuccessstate())
  }).catchError((e){
    emit(appREGISTERerrorstate("Register Failed Try again later !"));
  
  });

}).catchError((e){
  emit(appREGISTERerrorstate('Register failed try again later !'));
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