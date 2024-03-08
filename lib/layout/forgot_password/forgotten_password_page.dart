import 'package:chatapp/components/components.dart';
import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();

  var resetpw = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return   SafeArea(child: SizedBox(

      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(

                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.2,child: Image(image: AssetImage('assets/images/email.png'),fit: BoxFit.contain,)),
            Text("Reset your Password\n",style: GoogleFonts.poppins(fontSize:18.sp,fontWeight:FontWeight.w600),),
            Text("Thank you for Using our app\nPlease Enter your Email address\n",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w400),textAlign: TextAlign.center,),
        Form(
            key: _formKey,
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                                child: Text("Email Address",style: GoogleFonts.poppins(fontSize:18.sp,fontWeight:FontWeight.w500),textAlign: TextAlign.start,)),
                  ),
                  defaultTextFormField(hint: "Email@emailservice.com",label: "Email Address",controller: resetpw, type: TextInputType.emailAddress, validate: (value){
                    if(value.isEmpty) {
                      return 'Please enter Email Address';
                    }
                    return null;
                  }, radius: 10.r),
                ],
              ),SizedBox(height: 20.h),

              Align(
                  alignment: Alignment.bottomCenter,
                  child: defaultbottom(height: 20.h, function: (){
                    Socialappcubit.get(context).resetPassword(email: resetpw.text);
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Email sent! Check your inbox!',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: 14.sp)),
            backgroundColor: Colors.green),
      );
    }
                  }, text: "Send link",radius: 10.r))
            ],
          ),
        ))


          ],
        ),
      ),
    ));
  }
}
