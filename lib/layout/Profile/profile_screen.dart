import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/apptheme.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return  Socialappcubit(SocialappGETUSERinitialstate())..getUserData()..getuserposts(); },
      child: BlocConsumer<Socialappcubit, socialappstate>( listener: (BuildContext context, Object state) {

      },
        builder: (BuildContext context, state) {
          var cubit = Socialappcubit.get(context).usermodel;
          var postcubit = Socialappcubit.get(context);

          return   Scaffold(
          body:
          ConditionalBuilder(condition: state is SocialappGETUSERsuccessstate || state is SocialappUSERPOSTSsuccessstate , builder: (BuildContext context) {
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
                    '${cubit.name}',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '${cubit.bio!.isEmpty ? 'Empty Soul':cubit.bio}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),


                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/createpost');
                          },
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

                  ),
                  Divider(
                    height: 20.h,
                  ),

                  ConditionalBuilder(condition: postcubit.userposts.isNotEmpty, builder: (context){
                    return  Expanded(child:
                    GridView.count(crossAxisCount: 4,scrollDirection: Axis.vertical,children: List.generate(postcubit.userposts.length , (index)  {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                          },
                          child:  cubit.uId == postcubit.userposts[index].uId ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.height * 0.25,
                            child:postcubit.userposts[index].postimage.length > 0 ? Image.network('${ postcubit.userposts[index].postimage}',fit: BoxFit.cover,):
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(10.0.r),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10.0.r)
                                ),
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    postcubit.userposts[index].text
                                    ,
                                    style: TextStyle(
                                        fontSize: darktheme.textTheme.bodySmall!.fontSize, fontWeight: FontWeight.bold, color:lighttheme.textTheme.bodyLarge!.color),
                                  ),
                                ),
                              ),
                            ),
                          ):const Center(
                            child: Text("yet to upload"),
                          ),
                        ),
                      );


                    }),)
                    );
                  }, fallback:(context){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                           Center(
                             child: Text("You haven't uploaded anything yet",style: GoogleFonts.poppins(
                               fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold
                             ), textAlign: TextAlign.center,),
                           ),

                      ],
                    );
                  })



                ],
              ),
            );

          }, fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator(),);
          },
            ),
        );

        },
      ),
    );
  }
}
