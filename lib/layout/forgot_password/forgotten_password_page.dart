import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(

                width: 80.w,
                height: 80.h,child: Image(image: AssetImage('assets/images/email.png'),fit: BoxFit.cover,)),
            Text("Verify your email address",style: GoogleFonts.poppins(fontSize:16.sp,fontWeight:FontWeight.w600),)


          ],
        ),
      ),
    ));
  }
}
