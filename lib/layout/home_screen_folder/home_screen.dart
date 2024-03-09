import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../../components/components.dart';
import 'package:timeago/timeago.dart' as timeago;


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

var controller = TextEditingController();
 List? comments;
List? posts;
UserModel? user;

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return Socialappcubit(SocialappHOMEinitialstate())
          ..getPosts()
          ..getUserData()
          ..getusers();
      },
      child: BlocConsumer<Socialappcubit, socialappstate>(
        listener: (BuildContext context, socialappstate state) {
          if (state is SocialappGETCOMMENTSSuccessstate) {
            comments = state.commentmodel;

          }
          if (state is SocialappGETUSERsuccessstate) {
            user = state.usermodel;

          }
          if (state is SocialappGETPOSTSSuccessstate) {
            posts = state.postmodel;

          }
        },
        builder: (BuildContext context, socialappstate state) {
          return ConditionalBuilder(
            condition: Socialappcubit.get(context).posts.isNotEmpty &&
                Socialappcubit.get(context).usermodel != null,
            builder: (BuildContext context) {
              var cubit = Socialappcubit.get(context);

              return SafeArea(
                child: Column(children: [
                  Expanded(
                      child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
//default post card  in home screen
                      return defaultPostcard(
                        postid: cubit.postsid[index],
                          profileimage:
                              Socialappcubit.get(context).posts[index].image,
                          name: Socialappcubit.get(context).posts[index].name,
                          time: timeago.format(DateTime.parse(
                              Socialappcubit.get(context)
                                  .posts[index]
                                  .datetime!)),
                          text: Socialappcubit.get(context).posts[index].text,
                          postImage: posts?[index].postimage!.isEmpty
                              ? ""
                              : posts?[index].postimage,
                          like:
                              '${Socialappcubit.get(context).likes[index]}',
                          imageslength: 1,
                          context: context,
                          index: index,
                          onpresscomment: () {
                          print(cubit.postsid[index]);
                            Socialappcubit.get(context)
                                .getcomments(postid: cubit.postsid[index]);

                            showModalBottomSheet(
                              isScrollControlled:true,
                              enableDrag: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0.r),
                              ),
                              backgroundColor: Colors.white,

                              builder: (BuildContext context) {
                                return Scaffold(
                                  bottomNavigationBar:  ConditionalBuilder(
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
                                                      postid: cubit
                                                          .postsid[
                                                      index]);
                                                  Socialappcubit.get(context)
                                                      .getcomments(postid: cubit.postsid[index]);
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
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                  backgroundColor: Colors.white,
                                  body: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Flex(
                                        direction: Axis.vertical,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: 50.w,
                                                      height: 5.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.r),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Comments',
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.8 ,
                                                    width: MediaQuery.of(context).size.width * 1,
                                                    child: ConditionalBuilder(
                                                      condition: state is SocialappGETCOMMENTSSuccessstate || comments!.isNotEmpty,
                                                      builder:
                                                          (BuildContext context) {

                                                        return ListView.separated(
                                                          itemCount:
                                                          comments!.length,
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
                                                                    '${ comments![index].image}'),
                                                              ),
                                                              title: Text(
                                                                  '${comments![index].name}'),
                                                              subtitle: Text(
                                                                  '${comments![index].text}'),
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
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                );
                              },
                              context: context,
                            );
                          }, bio:Socialappcubit.get(context).posts[index].bio ?? "Empty Soul", stateofuse: '', uid: Socialappcubit.get(context).posts[index].uId );
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
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
