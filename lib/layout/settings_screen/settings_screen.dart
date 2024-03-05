import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Settings",style: GoogleFonts.poppins(fontSize:16.sp,fontWeight:FontWeight.bold,color:Colors.black),)),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        SizedBox(
          width: 45.w,
          height: 45.h,
          child: CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage('assets/images/account.png',headers: {

            }),
          ),
        ),
        Text("Account",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight:FontWeight.w500,color:Colors.black))
      ],

    ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
  ],
)
            ],
          ),
        ),
      ),
    );
  }
}
