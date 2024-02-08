import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:chatapp/components/apptheme.dart';
import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:timeago/timeago.dart' as timeago;

import 'package:ionicons/ionicons.dart';
Widget  buildchatitem(user, BuildContext context) {
  return Padding(
    padding:  EdgeInsets.all(5.r),
    child: InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/messagescreen',arguments: {'user':user});
      },
      child: Container(

        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          boxShadow: [

          ],
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.black,
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
                  '${user.name.toUpperCase()}',overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16.0.sp,fontWeight: FontWeight.bold,color: Colors.white
                  ),
                ),
                Text(
                  'Last message',
                  style: TextStyle(
                    fontSize: 16.0.sp,
                  ),overflow: TextOverflow.ellipsis,

                ),
              ],
            ),
          ],
        ),
      ),
    ),
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
focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white)
),
        focusColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.white
        ),

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
Widget DefaultButton({
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
      child: MaterialButton(
        height: height,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultImageContainer({
  String? image,
  File? imagefile,
  required double? width,
  required double? height,
  required double? radius,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        image: DecorationImage(
          image: image!.isEmpty
              ? Image.file(imagefile!) as ImageProvider<Object>
              : NetworkImage(image!),
          fit: BoxFit.cover,
        ),
      ),
    );

Widget defaultPostcard({
  required String? PROFILEimage,
  required String? name,
  required String? time,
  required String? text,
  required String? postImage,
  required String? like,


  required int? imageslength,required BuildContext context,required int index,
  required Function()? onpresscomment,
})
    {
      final ThemeData theme = Theme.of(context);
   return  Padding(
      padding: const EdgeInsets.all(20.0).w,
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 45.w,
              height: 45.h,
              child: CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(PROFILEimage!),
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
                  style:
                  TextStyle(
                      fontSize: darktheme.textTheme.bodyMedium!.fontSize, fontWeight: FontWeight.bold, color:darktheme.textTheme.bodyMedium!.color,),
                ),
                Text(
                  '',
                  style:
                  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w200),
                ),
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 30.sp,
                )),
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
              child: postImage!.isNotEmpty ? defaultImageContainer(
                  image: postImage,
                  width: double.infinity,
                  height: double.infinity,
                  radius: 10.0.r) : Center(
                child: Container(
                  padding: EdgeInsets.all(10.0.r),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0.r)
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      text!
                      ,
                      style: TextStyle(
                          fontSize: darktheme.textTheme.bodySmall!.fontSize, fontWeight: FontWeight.bold, color:lighttheme.textTheme.bodyLarge!.color),
                    ),
                  ),
                ),
              ),)
          /*
  * ListView.separated(
scrollDirection: Axis.horizontal,
itemBuilder: (context,index)=> defaultImageContainer(image: postImage, width:325.0.w , height: 120.h, radius: 10.0.r),
separatorBuilder: (context,index)=>SizedBox(width: 15.w,),
itemCount: imageslength!,
),
  * */
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Socialappcubit.get(context).likepost(Socialappcubit
                      .get(context)
                      .postsid[index]);
                },
                icon: Icon(
                  Ionicons.heart
                  ,
                  color: Colors.red,
                  size: 30.sp,
                )
            ),
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
            Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Ionicons.bookmark_outline
                  ,
                  size: 30.sp,
                )),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            like!.toString() + ' Likes',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w100),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            )),

        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              time!,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w100),
            )),
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
          icon: Icon(Icons.arrow_back_ios),
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
