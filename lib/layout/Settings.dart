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
      create: (BuildContext context) { return  Socialappcubit(SocialappGETUSERinitialstate())..getUserData()..Getuserposts(); },
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
                    '${cubit.bio}',
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
                  ConditionalBuilder(condition: postcubit.userposts.length != 0, builder: (context){
                    return  Expanded(child:
                    GridView.count(crossAxisCount: 4,scrollDirection: Axis.vertical,children: List.generate(postcubit.userposts.length , (index)  {

                      return GestureDetector(
                        onTap: (){
                          print(postcubit.userposts[index].uId);
                          print(cubit.uId);
                        },
                        child:  cubit.uId == postcubit.userposts[index].uId ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.25,
                          child: Image.network('${ postcubit.userposts[index].image}',fit: BoxFit.cover,),
                        ):Center(
                          child: Text("yet to upload"),
                        ),
                      );


                    }),)
                    );
                  }, fallback:(context){
                    return Center(
                      child: Text("you have not upload anything yet !"),
                    );
                  })



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
