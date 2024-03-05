import 'package:chatapp/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/components.dart';
import '../../cubit/cubit.dart';
import '../../shared/local/cachehelper.dart';

class LOGINSCREEN extends StatefulWidget {
  const LOGINSCREEN({super.key});

  @override
  State<LOGINSCREEN> createState() => _LOGINSCREENState();
}

var emailfield = TextEditingController();
var passwordfield = TextEditingController();

class _LOGINSCREENState extends State<LOGINSCREEN> {
  bool pwobscure = true ;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) {
        return appcubit(appLOGINinitialstate());
      },
      child: BlocConsumer<appcubit, appstate>(
        listener: (BuildContext context, Object? state) {
          if (state is appLOGINsuccessstate) {
            StorageUtil.putString('uid', state.uid ?? "");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Success')),
            );
            Navigator.pushReplacementNamed(context, '/main');
          }
          if (state is appLOGINerrorstate) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Something gone Wrong try again later")),
            );
          }
        },
        builder: (BuildContext context, state) {

          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding:  EdgeInsets.all(20.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Login now to browse our World',
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
                              controller: emailfield,
                              label: "Email Address",
                              hint: 'example@hint.com',
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
                              obscure: pwobscure ,
                              icon: Icons.lock_outline,
                              suffix:pwobscure ? Icons.visibility_off:Icons.visibility ,
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
                              radius: 10.0),
                          SizedBox(
                            height: 5.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: GestureDetector(
                                onTap: (){

                                },
                                child: Text("Forgot password ?",style: GoogleFonts.poppins(color:Colors.blue),)),
                          )
                      ,
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
                              condition: state is! appLOGINloadingstate,
                              builder: (BuildContext context) {
                                return MaterialButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      appcubit
                                          .get(context)
                                          .login(
                                              email: emailfield.text,
                                              password: passwordfield.text)
                                          .then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                   SnackBar(
                                                      content: Text(
                                                          'checking...',style: GoogleFonts.poppins(color: Colors.white,fontSize: 14.sp)),backgroundColor:Colors.grey),
                                                )
                                              })
                                          .catchError((e) {
                                      ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                             SnackBar(
                                                content: Text(
                                                    'login Failed Wrong E-mail or Password!',style: GoogleFonts.poppins(color: Colors.white,fontSize: 14.sp),)
                                            ,backgroundColor:Colors.red
                                            ),
                                        );
return 'Error';
                                      });

                                    }
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    'LOGIN',
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
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  'REGISTER',
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
                    ),SizedBox(height: 25.h,),
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
