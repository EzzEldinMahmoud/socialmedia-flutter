import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/layout/Homescreen.dart';
import 'package:chatapp/models/usermodel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math' as math;
import '../components/components.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'Homescreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}
var controller =
TextEditingController();
 List? comments ;
 List? posts;
 UserModel? user;
class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Socialappcubit, socialappstate>(
      listener: (BuildContext context, socialappstate state) {
    if (state is SocialappGETCOMMENTSSuccessstate){
        comments = state.commentmodel ;

    }
    if(state is SocialappGETUSERsuccessstate){
user = state.usermodel;
    }
    if(state is SocialappGETPOSTSSuccessstate){
      posts = state.postmodel;
    }

      },
      builder: (BuildContext context, socialappstate state) {
        return ConditionalBuilder(
          condition: Socialappcubit.get(context).posts.length > 0
              ,
          builder: (BuildContext context) {
            var cubit = Socialappcubit.get(context);

            return SafeArea(
              child: Column(children: [
                Expanded(
                    child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {

                    return defaultPostcard(
                        PROFILEimage:
                            Socialappcubit.get(context).posts[index].image,
                        name: Socialappcubit.get(context).posts[index].name,
                        time: timeago.format(DateTime.parse(
                            Socialappcubit.get(context)
                                .posts[index]
                                .datetime!)),
                        text: Socialappcubit.get(context).posts[index].text,
                        postImage: Socialappcubit.get(context)
                                .posts[index]
                                .postimage!
                                .isEmpty
                            ? ""
                            : Socialappcubit.get(context)
                                .posts[index]
                                .postimage,
                        like: '${Socialappcubit.get(context).likes[index]?? 0}',
                        imageslength: 1,
                        context: context,
                        index: index,
                        onpresscomment: () {

Socialappcubit.get(context).getcomments(postid: cubit.postsid[index]);

                          showModalBottomSheet(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: Colors.white,
                            constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height *
                                    1,
                            minHeight: 0.8,),

                            builder: (BuildContext context) {

                              return Scaffold(
                                backgroundColor: Colors.white,
                                body: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Flex(direction: Axis.vertical, children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 50.w,
                                              height: 5.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              'Comments',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          Expanded(
                                            child:  ConditionalBuilder(condition: comments != null , builder: (BuildContext context) {
                                              return SingleChildScrollView(
                                                child: ListView.separated(
                                                  itemCount:comments
                                                      !.length ,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {

return ListTile(
  leading: CircleAvatar(
    radius: 30.r,
    backgroundImage: NetworkImage('${comments?[index].image}'),
  ),
  title: Text('${comments?[index].name}'),
  subtitle: Text('${comments?[index].text}'),
  trailing: IconButton(onPressed: (){}, icon: Icon(Ionicons.heart_outline , size: 30.sp,)),
);

                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return SizedBox(
                                                      height: 10.h,
                                                    );
                                                  },

                                                  shrinkWrap: true,
                                                ),

                                              );
                                            }, fallback: (BuildContext context) {

                                              return Align(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Text("no comments for now" , style: TextStyle(fontSize: 18.sp , fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              );
                                            },

                                            ),



                                          ),
                                          ConditionalBuilder(condition: cubit.usermodel != null , builder: (BuildContext context) {
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
                                                      backgroundImage: NetworkImage('${cubit.usermodel?.image}'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: controller,
                                                      keyboardType:
                                                      TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelText:
                                                        'Write a comment',
                                                        hintText:
                                                        'Write a comment',
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Socialappcubit.get(context).CreateComment(

                                                            datetime:
                                                            DateTime.now().toString(),

                                                            text: controller.text,

                                                            postid: cubit.postsid[index]);
                                                        controller.clear();

                                                      },
                                                      icon: Icon(
                                                        Ionicons.send,
                                                        size: 30.sp,
                                                      )),
                                                ],
                                              ),
                                            );

                                          }, fallback: (BuildContext context) {
                                            return Center(
          child:Text("no comments for now" , style: TextStyle(fontSize: 18.sp , fontWeight: FontWeight.bold),
                                            ));
                                          },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            }, context: context,
                          );
                        });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: Socialappcubit.get(context).posts.length,
                  shrinkWrap: true,
                ))
              ]),
            );
          },
          fallback: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        );
      },
    );
  }
}
