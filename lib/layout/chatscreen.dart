import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CHATSCREEN extends StatefulWidget {
  const CHATSCREEN({super.key});

  @override
  State<CHATSCREEN> createState() => _CHATSCREENState();
}
List? users;
class _CHATSCREENState extends State<CHATSCREEN> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) { return  Socialappcubit(SocialappGETALLUSERinitialstate())..getusers(); },
      child: BlocConsumer<Socialappcubit,socialappstate>(listener: (context, state){
      if (state is SocialappGETALLUSERsuccessstate) {
        users = state.users;
      print(users);
      }
      }, builder: (context, state){
        return ConditionalBuilder(condition: users != null , builder: (BuildContext context){
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildchatitem(users?[index], context),
            separatorBuilder: (context, index) =>  Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: const Divider(
                thickness: 0,
              ),
            ),
            itemCount: users!.length,
          );
        }, fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.black,),),);


      }
          ),
    );
  }

  buildchatitem(user, BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(20.r),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/messagescreen',arguments: {'user':user});
        },
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey[100],
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
                      fontSize: 16.0.sp,fontWeight: FontWeight.bold,
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
}
