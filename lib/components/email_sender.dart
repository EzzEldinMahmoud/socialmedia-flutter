

import 'package:chatapp/components/components.dart';
import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportDialog extends StatefulWidget {
   const ReportDialog({super.key, required this.problemId});
 final  String problemId;
  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final _formKey = GlobalKey<FormState>();
  var problemTitle= TextEditingController();
  var text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Socialappcubit,socialappstate>(
        listener: (BuildContext context, socialappstate state) {
          if (state is SocialappSendEmailSuccessState){
            ScaffoldMessenger.of(context)
                .showSnackBar(
                SnackBar(backgroundColor: Colors.green,
                    content:
                    Text("Report sent",style: GoogleFonts.poppins(fontSize:11.sp,color:Colors.white),)));
          }
          else if (state is SocialappSendEmailerrorstate){
            ScaffoldMessenger.of(context)
                .showSnackBar(
                SnackBar(backgroundColor: Colors.red,
                    content:
                    Text("failed to send report try again later",style: GoogleFonts.poppins(fontSize:10.sp,color:Colors.white),)));
          }
        },
        builder: (context,state) {
          return Container(

            padding: EdgeInsets.all(20.r),
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),color: Colors.white
            ),

            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                              alignment:Alignment.topLeft,
                              child: Text("Report Title ",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w600),textAlign: TextAlign.start,)),
                          defaultTextFormField(hint:"please describe your problem related domain...",controller: problemTitle, type: TextInputType.text, validate:  (value) {
                            if (value.isEmpty) {
                              return 'Please specify your problem related domain..';
                            }
                            return null;
                          }, radius: 10.0.r),

                        ],
                      ) )  ,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Align(
                                alignment:Alignment.topLeft,
                                child: Text("Report Description ",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w600),textAlign: TextAlign.start,)),
                            TextFormField(
                              controller: text,
                              decoration:  InputDecoration(
                                  hintText:"please describe your problem",
                                  hintStyle: GoogleFonts.poppins(fontSize:10.sp,fontWeight:FontWeight.w300),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),

                                  )
                              ),
                            )
                          ]),
                    ),
                  )  ,
                  const Spacer(),
                  defaultbottom(radius: 20.r,height: 20.h, function: (){
                    if (_formKey.currentState!.validate()) {
                      Socialappcubit.get(context).sendReport(username: StorageUtil.getString('name'), userEmail: StorageUtil.getString('email'), text: text.text, problemId: widget.problemId, problemTitle: problemTitle.text, userId: StorageUtil.getString('uId'));
                    Navigator.pop(context);
                    }
                  }, text: "Send Report")
                ],
              ),
            ),
          );
        },
      );


  }
}
