import 'package:chatapp/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/socialcubit/socialcubit.dart';
import '../../cubit/socialcubit/socialstates.dart';

class EditProfile extends StatefulWidget {
 const  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


var phonecontroller = TextEditingController();
var namecontroller = TextEditingController();
var biocontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) {
        return Socialappcubit(SocialappGETUSERinitialstate())..getUserData();
      },
      child: BlocConsumer<Socialappcubit, socialappstate>(
        listener: (BuildContext context, Object state) {},
        builder: (BuildContext context, state) {

          var cubit = Socialappcubit.get(context).usermodel;
          var profileimage = Socialappcubit.get(context).profileImage;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                TextButton(
                    onPressed: () {
                      Socialappcubit.get(context).updateuserdata(
                          name:  namecontroller.text.isNotEmpty  ?  namecontroller.text : cubit?.name,
                          phone:  phonecontroller.text.isNotEmpty ?  phonecontroller.text : cubit?.phone,
                          bio:  biocontroller.text.isNotEmpty ? biocontroller.text : cubit?.bio,
                          image: Socialappcubit.get(context).profileimageurl.isNotEmpty  ?  Socialappcubit.get(context).profileimageurl : cubit?.image);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! SocialappGETUSERloadingstate,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(15.0).w,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Socialappcubit.get(context)
                                        .getProfileImage(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 100.0.r,
                                    backgroundImage: profileimage == null
                                        ? NetworkImage('${cubit?.image}')
                                        : FileImage(profileimage)
                                            as ImageProvider,
                                  )),
                              CircleAvatar(
                                  radius: 25.0.r,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: () {
                                        Socialappcubit.get(context)
                                            .getProfileImage(context);
                                      },
                                      icon: const Icon(Icons.camera_alt_outlined)))
                            ]),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (state is SocialappGETPROFILEIMAGESuccessstate)
                          Column(children: [
                            OutlinedButton(
                              onPressed: () {
                                Socialappcubit.get(context).uploadprofileImage(
                                    name: cubit?.name ?? namecontroller.text,
                                    phone: cubit?.phone ?? phonecontroller.text,
                                    bio: cubit?.bio ?? biocontroller.text);
                              },
                              child:  Text('Change Profile Image',style: GoogleFonts.poppins(color:Colors.black),),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]),
                        Column(
                          children: [

                            defaultTextFormField(controller: namecontroller , label: "User Name",hint: '${ cubit?.name }', type: TextInputType.name, obscure: false, icon: Icons.person_outline, validate: (value){
                              if (value.isEmpty) {
                                return 'Please enter User Name';
                              }
                              return null;
                            }, radius: 10.0),



                            SizedBox(
                              height: 20.h,
                            ),

                            defaultTextFormField(controller: biocontroller, label: "Bio" ,hint: '${ cubit?.bio }',type: TextInputType.name,  icon: Icons.person_outline, validate: (value){
                              if (value.isEmpty) {
                                return 'Please enter User Name';
                              }
                              return null;
                            }, radius: 10.0),



                            SizedBox(
                              height: 20.h,
                            ),
                            defaultTextFormField(controller: phonecontroller, label: "phone number",hint: '${ cubit?.phone }' , type: TextInputType.phone,  icon: Icons.phone_android_outlined, validate: (value){
                              if (value.isEmpty) {
                                return 'Please enter  Phone Number';
                              }
                              return null;
                            }, radius: 10.0.sp),

                          ],
                        )

                      ],
                    ),
                  ),
                );
              },
              fallback: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
