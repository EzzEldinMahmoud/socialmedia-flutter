import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

var username = TextEditingController();
var emailfield = TextEditingController();
var passwordfield = TextEditingController();
var phonefield = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  bool pwobscure = true ;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return appcubit(appREGISTERinitialstate());
      },
      child: BlocConsumer<appcubit, appstate>(
        listener: (BuildContext context, Object? state) {
          if (state is appREGISTERsuccessstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Register Success!',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 14.sp)),
                  backgroundColor: Colors.green),
            );
          }
          if (state is appREGISTERerrorstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    'Register Failed Try again later!',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 14.sp),
                  ),
                  backgroundColor: Colors.red),
            );
          }
          if (state is appCREATEUSERsuccessstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Create User Success',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 14.sp)),
                  backgroundColor: Colors.green),
            );
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (BuildContext context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Sign Up now to browse our World',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          defaultTextFormField(
                              controller: username,
                              label: "User Name",
                              hint: 'closeworld',
                              type: TextInputType.name,
                              obscure: false,
                              icon: Icons.person_outline,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter User Name';
                                }
                                return null;
                              },
                              radius: 10.0),
                          SizedBox(
                            height: 20.h,
                          ),
                          defaultTextFormField(
                              controller: emailfield,
                              label: "Email Address",
                              hint: 'closeworld@hint.com',
                              type: TextInputType.emailAddress,
                              obscure: false,
                              icon: Icons.email_outlined,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Email';
                                }
                                return null;
                              },
                              radius: 10.0),
                          SizedBox(
                            height: 20.h,
                          ),
                          defaultTextFormField(
                              controller: passwordfield,
                              label: "Password",
                              hint: 'EXAMPLEhere123@#',
                              type: TextInputType.visiblePassword,
                              obscure: pwobscure,
                              icon: Icons.lock_outline,
                              suffix: pwobscure ? Icons.visibility_off:Icons.visibility,
                              suffixPressed: (){
                                setState(() {
                                  pwobscure = ! pwobscure;

                                });
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter  Password';
                                }
                                return null;
                              },
                              radius: 10.0.sp),
                          SizedBox(
                            height: 20.h,
                          ),
                          defaultTextFormField(
                              controller: phonefield,
                              label: "Phone Number",
                              hint: 'Phone Number',
                              type: TextInputType.phone,
                              obscure: false,
                              icon: Icons.phone_android_outlined,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter  Phone Number';
                                }
                                return null;
                              },
                              radius: 10.0.sp),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ConditionalBuilder(
                              condition: state is! appREGISTERloadingstate,
                              builder: (BuildContext context) {
                                return MaterialButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      appcubit
                                          .get(context)
                                          .register(
                                              email: emailfield.text,
                                              password: passwordfield.text,
                                              username: username.text,
                                              phone: phonefield.text)
                                          .then((value) {
                                        if (value['status'] == true) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text(value['message'])),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Something went wrong try again later",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 14.sp))),
                                          );
                                        }
                                      }).catchError((onError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Something went wrong try again later",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 14.sp),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                              fallback: (BuildContext context) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    termsandpolicy(context)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
