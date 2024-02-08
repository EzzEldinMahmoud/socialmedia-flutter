import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/components.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
var search = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *0.02,
          ),
          Container(
            height: MediaQuery.of(context).size.height *0.15,
            padding: EdgeInsets.symmetric(vertical:30.h,horizontal: 25.w),
            child: Form(
              key: _formKey,
              child: defaultTextFormField(
                  controller: search,
                  label: "Search...",
            
                  type: TextInputType.text,
                  obscure: false,
                  icon: Icons.search,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please search...';
                    }
                    return null;
                  },
                  radius: 25.0.r),
            ),
          ),
        ],
      ),
    );
  }
}
