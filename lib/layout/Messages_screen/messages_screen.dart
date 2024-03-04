
import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
class Messagesscreen extends StatefulWidget {

   const Messagesscreen({super.key, });


  @override
  State<Messagesscreen> createState() => _MessagesscreenState();
}

class _MessagesscreenState extends State<Messagesscreen> {
  var message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final user = arguments['user'];
    return Builder(
      builder: (context) {
        Socialappcubit.get(context).getmessages(receiverId: user.uId);
        return BlocConsumer<Socialappcubit,socialappstate>(listener: (context, state){

        },builder: (context,state){

          return Scaffold(
            appBar: AppBar(
              title: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [

                    CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                    ),
                     SizedBox(width: 5.0.w,),
                    Expanded(
                      flex: 1,
                      child: Text(user.name, overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20.0),

                      ),
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.add_ic_call))
                  ],
                ),
              ),
            ),
            body:Flex(

              direction: Axis.vertical,
              children:[ Expanded(
                child: ConditionalBuilder(
                  condition: Socialappcubit.get(context).messages.isNotEmpty ,
                  builder: (BuildContext context) {

                    return ListView.separated(physics: const BouncingScrollPhysics(),itemBuilder: (context,index){


                    if(Socialappcubit.get(context).messages[index].senderId == Socialappcubit.get(context).uid){
                      return buildmymessageitem(Socialappcubit.get(context).messages[index].text,Socialappcubit.get(context).messages[index].datetime);
                    }else{
                      return buildmessageitem(Socialappcubit.get(context).messages[index].text,Socialappcubit.get(context).messages[index].datetime);
                    }




                    }, separatorBuilder: (context,state){
                      return SizedBox(height: 15.h,);
                    }, itemCount: Socialappcubit.get(context).messages.length);
                  },
                  fallback: (BuildContext context) {
                    return Center(child: Text(
                      "Send messages and start chatting with your friends!",textAlign: TextAlign.center,style: GoogleFonts.poppins(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 18.sp),
                    ),);
                  },

                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
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
                          controller:message,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type your message here ...',
                            hintStyle: GoogleFonts.poppins(fontSize: 14.sp)
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0.w,),
                     /* IconButton(

                        onPressed: (){
                         showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text('Add Image'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Camera'),
                                    onTap: (){},
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text('Gallery'),
                                    onTap: (){},
                                  ),
                                ],
                              ),
                            );
                         });
                        },
                        icon: const Icon(Icons.attach_file),
                      ) ,*/
                      SizedBox(width: 5.0.w,),
                      CircleAvatar(
                        backgroundColor: Colors.blue[300],
                        radius: 25.0.r,
                        child: Transform.rotate(
                          angle: -0.5,
                          child: IconButton(

                            onPressed: (){

                              Socialappcubit.get(context).sendmessage(receiverId: user.uId, dateTime: DateTime.now().toString(), text: message.text);
                           message.clear();
                            },
                            icon: const Icon(Icons.send,color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )


              ]
            ),
          );
        },);
      }
    );
  }
  Widget buildmymessageitem (message, String? datetime) => Align(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end
,
          children: [
            Text(message,style: GoogleFonts.poppins(color: Colors.white,fontSize: 14.sp),),
            Text(timeago.format(DateTime.parse(datetime!
                )),style: GoogleFonts.poppins(color: Colors.white,fontSize: 8.sp),),
          ],
        ),
      ),
    ),
  );
  Widget buildmessageitem(message, String? datetime) => Align(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
          children: [
            Text(message,style: GoogleFonts.poppins(color: Colors.black,fontSize: 14.sp),),
            Text(timeago.format(DateTime.parse(datetime!
            )),style: GoogleFonts.poppins(color: Colors.black,fontSize: 8.sp),),
          ],
        ),
      ),
    ),
  );
}
