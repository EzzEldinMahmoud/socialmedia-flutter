import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/components.dart';

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

      }
      }, builder: (context, state){
        return ConditionalBuilder(condition: users != null , builder: (BuildContext context){
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,

              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildchatitem(users?[index], context),
                separatorBuilder: (context, index) =>  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: const Divider(
                    thickness: 0,
                  ),
                ),
                itemCount: users!.length,
              ),
            ),
          );
        }, fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.black,),),);


      }
          ),
    );
  }


}
