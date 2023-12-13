import 'package:chatapp/components/components.dart';
import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return  Socialappcubit(SocialappGETUSERinitialstate())..getUserData(); },
      child: BlocConsumer<Socialappcubit, socialappstate>( listener: (BuildContext context, Object state) {

      },
        builder: (BuildContext context, state) {
          var cubit = Socialappcubit.get(context).usermodel;
        return   Scaffold(
          body:
          ConditionalBuilder(condition: state is! SocialappGETUSERloadingstate, builder: (BuildContext context) {
            return  Padding(
              padding: const EdgeInsets.all(15.0).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 190.h,
                    width: 190.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                             cubit!.image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '${cubit?.name}',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '${cubit?.bio}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[
                        defaultTitleDesc(title: '100', desc: 'Posts', context: context),
                        defaultTitleDesc(title: '230', desc: 'Photos', context: context)
                        ,defaultTitleDesc(title: '10k', desc: 'Followers', context: context)
                        ,defaultTitleDesc(title: '64', desc: "Following", context: context)


                      ]
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Photos',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/editprofile');
                        },
                        child: Icon(
                          Icons.edit,
                          size: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],

                  )
                ],
              ),
            );

          }, fallback: (BuildContext context) {
            return Center(child: CircularProgressIndicator(),);
          },
            ),
        );

        },
      ),
    );
  }
}
