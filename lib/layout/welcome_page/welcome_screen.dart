import 'package:chatapp/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {

    return   SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SizedBox(height: 300.h,width: double.infinity,child: Image.asset('assets/images/welcome.jpg',fit: BoxFit.contain,),),
                  Text("Hello There,\nWelcome to our Closeworld!",style: GoogleFonts.poppins(fontSize: 18.sp),),
                  SizedBox(
                    height: 50.h,
                  ),
                  defaultbottom(
                      radius: 10.0.r
                      ,function: (){
                    Navigator.pushNamed(context, '/login');
                  }, text: 'LOGIN', height: 200.0.h),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultbottom(
                      radius: 10.0.r,
                      function: (){
                    Navigator.pushNamed(context, '/register');
                  }, text: 'REGISTER', height: 200.0.h),
                  const Spacer(),
               termsandpolicy(context)

                ]

              ),
              ),
          ),
        );

  }
}