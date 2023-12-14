import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Messagesscreen extends StatefulWidget {

   const Messagesscreen({super.key, });


  @override
  State<Messagesscreen> createState() => _MessagesscreenState();
}

class _MessagesscreenState extends State<Messagesscreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final user = arguments['user'];
    return BlocConsumer<Socialappcubit,socialappstate>(builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [

              CircleAvatar(
                backgroundImage: NetworkImage(user.image),
              ),
               SizedBox(width: 10.0.w,),
              Text(user.name,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20.0),
              overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        body:Flex(
          direction: Axis.vertical,
          children:[ Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildmymessageitem('hello'),
                  buildmessageitem('hello'),
                 
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(15.0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0.r),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type your message here ...',
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0.w,),
                    CircleAvatar(
                      backgroundColor: Colors.blue[300],
                      radius: 25.0.r,
                      child: Transform.rotate(
                        angle: -0.5,
                        child: IconButton(

                          onPressed: (){},
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )


          ]
        ),
      );
    }, listener: (context, state){

    },);
  }
  Widget buildmymessageitem (message) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 10.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0.r),
            topStart: Radius.circular(10.0.r),
            bottomStart: Radius.circular(10.0.r),
          ),
          color: Colors.blue[300],
        ),
        child: Text(message),
      ),
    ),
  );
  Widget buildmessageitem(message) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 10.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0.r),
            bottomEnd: Radius.circular(10.0.r),
            bottomStart: Radius.circular(10.0.r),
          ),
          color: Colors.grey[300],
        ),
        child: Text(message),
      ),
    ),
  );
}
