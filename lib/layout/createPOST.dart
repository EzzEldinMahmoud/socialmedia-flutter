import 'package:chatapp/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/socialcubit/socialcubit.dart';
import '../cubit/socialcubit/socialstates.dart';

class CREATEPOST extends StatefulWidget {
  const CREATEPOST({super.key});

  @override
  State<CREATEPOST> createState() => _CREATEPOSTState();
}

var textcontroller = TextEditingController();

class _CREATEPOSTState extends State<CREATEPOST> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return Socialappcubit(SocialappCreatePostinitialstate())..getUserData();
      },
      child: BlocConsumer<Socialappcubit, socialappstate>(
        listener: (BuildContext context, Object? state) {
          if (state is SocialappCreatePostsuccessstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                Text('Post Created Successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushNamed(context, '/main');
          } else if (state
          is SocialappCreatePostImageERRORstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is SocialappCreatePostImageSuccessstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                Text('Post Created Successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushNamed(context, '/main');

          } else if (state
          is SocialappCreatePostImageERRORstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
          var cubit = Socialappcubit.get(context).usermodel;

          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultappbar(
                      context: context,
                      title: "Create Post",
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (Socialappcubit.get(context).postimagehere ==
                                  null) {
                                Socialappcubit.get(context).CreatePost(
                                    datetime: '${DateTime.now()}',
                                    postimage: '',
                                    text: textcontroller.text);

                              } else {
                                Socialappcubit.get(context).uploadPostImage(
                                    datetime: '${DateTime.now()}',
                                    text: textcontroller.text);

                              }
                            }
                          },
                          child: Text(
                            'Post',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Socialappcubit.get(context).getpostImage(context);
                          },
                          icon: Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              body: Flex(direction: Axis.vertical, children: [
                Expanded(
                  child: Column(
                    children: [
                      if (state is SocialappCreatePostloadingstate)
                        LinearProgressIndicator(),
                      if (state is SocialappCreatePostImageLOADINGstate)
                        LinearProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cubit?.image ??
                                        'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: 200.w,
                              height: 50.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${cubit?.name?.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'What are you feeling?',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Type Something';
                                    }
                                    return null;
                                  },
                                  controller: textcontroller,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
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
                              Spacer(),
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
                                        ? Image.file(
                                            Socialappcubit.get(context)
                                                .postimagehere!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 200.h,
                                          )
                                        : SizedBox(),
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
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
