import 'dart:convert';

import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/socialcubit/socialcubit.dart';

class EditUserPost extends StatefulWidget {
  const EditUserPost({super.key, required this.text, required this.postimage, required this.postid});
final String text;
  final String postimage;
  final String postid;

  @override
  State<EditUserPost> createState() => _UserPostState();
}

class _UserPostState extends State<EditUserPost> {
  final _formKey = GlobalKey<FormState>();
  var description = TextEditingController();
  @override
  void initState() {
    super.initState();
  description.text = widget.text;
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(child:

    BlocConsumer<Socialappcubit,socialappstate>(
        builder: (context,state) {

          return Scaffold(
            appBar: AppBar(
              title: Text("Edit post",style: GoogleFonts.poppins(fontSize:16.sp)),actions: [
              TextButton(onPressed: (){
                Socialappcubit.get(context).editMyPost(postid: widget.postid, postimage: Socialappcubit.get(context).postimagehere ?? '', text: description.text);
                if( state is SocialappEditUserPostLOADINGstate)
                {  const LinearProgressIndicator();}
                else if(
                state is SocialappEditUserPostSuccessstate
                ){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Post Edited!',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 14.sp)),
                        backgroundColor: Colors.green),
                  );
                }else if(state is SocialappEditUserPostSERRORstate){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Something went wrong try again later! ',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 14.sp)),
                        backgroundColor: Colors.red),
                  );
                }
              }, child: Text("Edit Post",style: GoogleFonts.poppins(fontSize:16.sp,color:Colors.blue),))
            ],
            ),
            body: Column(
              children: [

                Expanded(child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key:_formKey,child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Post Description",style: GoogleFonts.poppins(fontSize:14.sp),),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Type Something';
                            }
                            return null;
                          },
                          controller: description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                          decoration: InputDecoration(
                            hintText: 'What is on your mind?',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          Socialappcubit.get(context).getpostImage(context);
                        },
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {

                              },
                              icon: const Icon(
                                Icons.image,
                                color: Colors.black,
                              ),
                            ),Text("Change image",style: GoogleFonts.poppins(fontSize:14.sp))
                          ],
                        ),
                      ),
            SizedBox(height: 10.h,),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.grey[300],
                            ),
                            child: Socialappcubit.get(context)
                                .postimagehere !=
                                null
                                ? Image.memory(
                              base64Decode(Socialappcubit.get(context)
                                  .postimagehere!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200.h,
                            )
                                : const SizedBox(),
                          ),
                          Socialappcubit.get(context).postimagehere !=
                              null
                              ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.grey[300],
                              child: IconButton(
                                onPressed: () {
                                  Socialappcubit.get(context)
                                      .removepostimage();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  )
                  ),
                ) ,



                ),
              ],
            ),
          );
        }, listener: (BuildContext context, socialappstate state) {  },
      ),
    );
  }
}
