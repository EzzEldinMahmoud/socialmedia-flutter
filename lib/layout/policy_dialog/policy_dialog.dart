import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PolicyDialog extends StatefulWidget {
  const PolicyDialog({super.key, this.radius = 8.0, required this.mdFileName});
  final double radius;
  final String mdFileName;

  @override
  State<PolicyDialog> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<PolicyDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value) {
                return rootBundle.loadString(
                    'assets/Terms_conditions_privacy_policy/${widget.mdFileName}');
              }),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          MaterialButton(
            height: 50.h,
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(0),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(widget.radius),
                    bottomRight: Radius.circular(widget.radius))),
            child: Center(
                child: Text('I Agree',
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500))),
          )
        ],
      ),
    );
  }
}
