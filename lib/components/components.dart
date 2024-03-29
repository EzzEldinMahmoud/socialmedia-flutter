import 'dart:convert';
import 'dart:io';

import 'package:chatapp/components/apptheme.dart';
import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/layout/Messages_screen/messages_screen.dart';
import 'package:chatapp/layout/edit_user_post/edit_user_post.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ionicons/ionicons.dart';

import '../cubit/socialcubit/socialstates.dart';
import '../layout/policy_dialog/policy_dialog.dart';
import 'email_sender.dart';

Widget termsandpolicy(context) {
  return Align(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "By creating an account, you are agreeing to our\n ",
          style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const PolicyDialog(
                          mdFileName: 'terms_and_conditions.md',
                        );
                      });
                },
                child: Text("Terms & Conditions ",
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center)),
            Text(" and ",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const PolicyDialog(
                          mdFileName: 'privacy_policy.md',
                        );
                      });
                },
                child: Text("Privacy Policy! ",
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center)),
          ],
        )
      ],
    ),
  );
}

Widget buildchatitem(user, BuildContext context) {



  return BlocConsumer<Socialappcubit, socialappstate>(
    listener: (BuildContext context, Object? state) {},
    builder: (BuildContext context, state) {
      return Padding(
        padding: EdgeInsets.all(5.r),
        child: InkWell(
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return Messagesscreen(user: user);
            }));
          },
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              boxShadow: const [],
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0.r,
                  backgroundImage: NetworkImage('${user.image}'),
                ),
                SizedBox(
                  width: 20.0.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name.toUpperCase()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      user.bio.toString().isEmpty ?"Empty Soul":user.bio.toString(),
                      style: TextStyle(fontSize: 16.0.sp, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  String? label,
  String? hint,
  required TextInputType type,
  bool? obscure,
  IconData? icon,
  required Function(String) validate,
  required double radius,
  Function()? suffixPressed,
  IconData? suffix,
  String? initialValue,

}) =>
    TextFormField(

      initialValue: initialValue,
      controller: controller,
      keyboardType: type,
      obscureText: obscure ?? false,
      decoration: InputDecoration(

        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.black,
        labelText: label ?? '',
        hintText: hint ?? '',
        prefixIcon: Icon(icon),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      validator: (value) => validate(value!),
    );
Widget defaultbottom({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required double height,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: background),
        color: Colors.transparent,
      ),
      child: MaterialButton(
        height: height,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );

Widget defaultImageContainer({
  String? image,
  String? imagefile,
  required double? width,
  required double? height,
  required double? radius,
})
    {
      return Image(
          height: height,
          width: width,
          fit: BoxFit.cover,
          image:  image!.isEmpty
          ? Image.memory(base64Decode(image)).image
          : image.contains('http')  ?  NetworkImage(image): Image.memory(base64Decode(image)).image);
    }
Widget defaultPostcard({
  required String? profileimage,
  required String? name,
  required String? time,
  required String? text,
  required String? postImage,
  required String? like,
  required String? bio,
  required String? stateofuse,
  required String? uid,
  required int? imageslength,
  required BuildContext context,
  required String postid,
  int? index,
  Function()? onpresscomment,
}) {
  return Padding(
      padding: const EdgeInsets.all(20.0).w,
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 45.w,
              height: 45.h,
              child: CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(profileimage!),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: TextStyle(
                    fontSize: darktheme.textTheme.bodyMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: lighttheme.textTheme.bodyMedium!.color,
                  ),
                ),
                Text(
                  bio!,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w200),
                ),
              ],
            ),
            const Spacer(),
             PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r)),
                    color: Colors.white,
                    icon: Icon(
                      Icons.more_vert,
                      size: 30.sp,
                    ),
                    itemBuilder: (BuildContext context) {
                      if (StorageUtil.getString('uId') == uid) {
                        return [
                          PopupMenuItem(
                            child: Text(
                              "Report Post",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              showModalBottomSheet(context: context, builder: (context){
                                return ReportDialog(problemId: postid);
                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text(
                              "Edit Post",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return EditUserPost(text: text!, postimage: postImage!, postid: postid,);
                              }));
                            },
                          ),
                          PopupMenuItem(
                            child: Text(
                              "Delete Post",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            onTap: () {
                              showDialog(context: context, builder: (context){
                                return Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10.r),
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white,

                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Delete My Post',style: GoogleFonts.poppins(fontSize:16.sp,fontWeight:FontWeight.bold,color:Colors.black),textAlign: TextAlign.start,),
                                        Text('Are you really sure about this ?',style: GoogleFonts.poppins(fontSize:16.sp,fontWeight:FontWeight.w500,color:Colors.black),)
                                        ,Row(
                                          crossAxisAlignment:CrossAxisAlignment.end ,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(onPressed: (){
                                              Socialappcubit.get(context).deleteMyPost(postid: postid);
                                              Navigator.pop(context);
                                            }, child: Text('Yes',style: GoogleFonts.poppins(fontSize:12.sp,fontWeight:FontWeight.bold,color:Colors.red))),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('No',style: GoogleFonts.poppins(fontSize:12.sp,fontWeight:FontWeight.bold,color:Colors.black)))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });

                            },
                          ),
                        ];
                      } else {
                        return [
                          PopupMenuItem(
                            child: Text(
                              "Report Post",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {showModalBottomSheet(context: context, builder: (context){
                              return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 1
                              ,child: ReportDialog(problemId: postid ));
                            });},
                          ),
                          PopupMenuItem(
                            child: Text(
                              "Bookmark Post",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                          ),
                        ];
                      }
                    },
                  ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
            height: 220.h,
            width: 325.0.w,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 1,
              child: postImage!.length > 2
                  ? defaultImageContainer(
                      image: postImage,
                      width: double.infinity,
                      height: double.infinity,
                      radius: 10.0.r,imagefile: postImage)
                  : Center(
                      child: Container(
                        padding: EdgeInsets.all(10.0.r),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10.0.r)),
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            text!,
                            style: TextStyle(
                                fontSize:
                                    darktheme.textTheme.bodySmall!.fontSize,
                                fontWeight: FontWeight.bold,
                                color: lighttheme.textTheme.bodyLarge!.color),
                          ),
                        ),
                      ),
                    ),
            )
            /*
  * ListView.separated(
scrollDirection: Axis.horizontal,
itemBuilder: (context,index)=> defaultImageContainer(image: postImage, width:325.0.w , height: 120.h, radius: 10.0.r),
separatorBuilder: (context,index)=>SizedBox(width: 15.w,),
itemCount: imageslength!,
),
  * */
            ),
        Column(
          children: [
            stateofuse == 'singlepage'
                ? Container()
                : Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Socialappcubit.get(context).likepost(
                                Socialappcubit.get(context).postsid[index!]);
                          },
                          icon: Icon(
                            Ionicons.heart,
                            color: Colors.red,
                            size: 30.sp,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconButton(
                          onPressed: onpresscomment,
                          icon: Icon(
                            Ionicons.chatbubble_outline,
                            size: 30.sp,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.arrow_redo_outline,
                            size: 30.sp,
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.bookmark_outline,
                            size: 30.sp,
                          )),
                    ],
                  ),
            stateofuse == 'singlepage'
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${like!} Likes',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w100),
                    ),
                  ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  text!,
                  overflow: TextOverflow.visible,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  time!,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w100),
                )),
          ],
        ),
      ]));
}

Widget defaultappbar({
  required BuildContext? context,
  required String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      actions: actions!,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context!);
        },
        icon: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context!);
          },
        ),
      ),
      title: Text(
        title!,
      ),
    );
Widget defaultTitleDesc(
        {required String title,
        required String desc,
        required BuildContext context}) =>
    Center(
      child: Column(children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        Text(
          desc,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w200,
            fontSize: 12.sp,
          ),
        )
      ]),
    );
