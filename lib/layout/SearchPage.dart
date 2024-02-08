import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/components.dart';
import 'chatscreen.dart';

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
      appBar:AppBar(

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
            child: Form(
              key: _formKey,
              child: defaultTextFormField(
                  controller: search,
                  label: "Search...",
                  type: TextInputType.text,
                  obscure: false,
                  icon: Icons.search,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please search...';
                    }
                    return null;
                  },
                  radius: 25.0.r),
            ),
          ),
          Expanded(
            child: ConditionalBuilder(
              
              condition: users != null,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildchatitem(users?[index], context),
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: const Divider(
                          thickness: 0,
                        ),
                      ),
                      itemCount: users!.length,
                    ),
                  ),
                );
              },
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
