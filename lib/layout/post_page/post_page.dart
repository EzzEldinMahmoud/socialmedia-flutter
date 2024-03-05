import 'package:chatapp/components/components.dart';
import 'package:chatapp/models/singlepost.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/socialcubit/socialcubit.dart';
import '../../cubit/socialcubit/socialstates.dart';
import '../home_screen_folder/home_screen.dart';

class PostPage extends StatefulWidget {

  const PostPage({super.key,  required this.singlepost});
  final SinglePost singlepost;
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Socialappcubit.get(context).getcomments(postid: widget.singlepost.postid);
    return  BlocConsumer<Socialappcubit,socialappstate>(
     listener: (BuildContext context, state) {

     },
      builder: (context,state) {
        return Scaffold(
          bottomNavigationBar:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
              condition: user != null,
              builder:
                  (BuildContext context) {
                return SizedBox(
                  height: 60.h,
                  width: 325.w,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45.w,
                        height: 45.h,
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundImage:
                          NetworkImage(
                              '${user?.image}'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child:
                        TextFormField(
                          controller:
                          controller,
                          keyboardType:
                          TextInputType
                              .text,
                          decoration:
                          const InputDecoration(
                            labelText:
                            'Write a comment',
                            hintText:
                            'Write a comment',
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Socialappcubit.get(context).createcomment(
                                datetime: DateTime
                                    .now()
                                    .toString(),
                                text: controller
                                    .text,
                                postid: widget.singlepost.postid);
                            Socialappcubit.get(context)
                                .getcomments(postid: widget.singlepost.postid);
                            controller
                                .clear();
                          },
                          icon: Icon(
                            Ionicons.send,
                            size: 30.sp,
                          )),
                    ],
                  ),
                );
              },
              fallback:
                  (BuildContext context) {
                return Center(
                    child: Text(
                      "no comments for now",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight:
                          FontWeight.bold),
                    ));
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(

                children: [
                  defaultPostcard(profileimage: widget.singlepost.image, name:  widget.singlepost.name, time:  timeago.format(DateTime.parse( widget.singlepost.datetime.toString())), text:  widget.singlepost.text, postImage:  widget.singlepost.postimage!.isEmpty? '':widget.singlepost.postimage, like:  '2', bio:  widget.singlepost.bio ?? "Empty Soul", imageslength:  1, context: context, stateofuse: "singlepage", uid:widget.singlepost.uId, postid: widget.singlepost.postid!),
                  Column(
                    children: [

                      ConditionalBuilder(
                        condition:  Socialappcubit.get(context).comments.isNotEmpty,
                        builder:
                            (BuildContext context) {
                          return ListView.separated(
                            itemCount:
                            Socialappcubit.get(context).comments.length,
                            itemBuilder:
                                (BuildContext
                            context,
                                int index) {
                              return ListTile(
                                leading:
                                CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage:
                                  NetworkImage(
                                      '${Socialappcubit.get(context).comments[index].image}'),
                                ),
                                title: Text(
                                    '${Socialappcubit.get(context).comments[index].name}',overflow: TextOverflow.ellipsis,),
                                subtitle: Text(
                                    '${Socialappcubit.get(context).comments[index].text}'),
                                trailing:
                                IconButton(
                                    onPressed:
                                        () {},
                                    icon:
                                    Icon(
                                      Ionicons
                                          .heart_outline,
                                      size: 30
                                          .sp,
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext
                            context,
                                int index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                            shrinkWrap: true,
                          );
                        },
                        fallback:
                            (BuildContext context) {
                          return  Align(
                            alignment:
                            Alignment.center,
                            child: Center(
                              child:
                              Text("No comments for this post",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),),
                            ),
                          );
                        },
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
