import 'package:chatapp/layout/Edit_profile/edit_profile.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
         Container(
           width: double.infinity,
           height: MediaQuery.of(context).size.height * 0.1,
           decoration: BoxDecoration(
             color: Colors.white30,
             borderRadius: BorderRadius.circular(10.0.r)
           ),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(
                   width: 45.w,
                   height: 45.h,
                   child: CircleAvatar(
                     backgroundImage: NetworkImage(StorageUtil.getString('image')),
                   )),
               SizedBox(width: 8.w,),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("${StorageUtil.getString('name')}",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w600,color:Colors.black),textAlign: TextAlign.start,)
               ,
                   Flexible(child: Text("ID: ${StorageUtil.getString('uId')}",style: GoogleFonts.poppins(fontSize:12.sp,fontWeight:FontWeight.w300,color:Colors.grey),overflow: TextOverflow.ellipsis,))
                 ],
               )
             ],
           ),
         ),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EditProfile();
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
              width: 35.w,
              height: 35.h,
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('assets/images/account.png',),
              ),
                      ),SizedBox(width: 8.w,),
                      Text("Account",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                    ],

                  ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.h,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage('assets/images/bookmark.png',),
                            ),
                          ),SizedBox(width: 8.w,),
                          Text("Bookmarks",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                        ],

                      ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.h,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage('assets/images/chat.png',),
                            ),
                          ),SizedBox(width: 8.w,),
                          Text("Chat",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                        ],

                      ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.h,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage('assets/images/privacy.png',),
                            ),
                          ),SizedBox(width: 8.w,),
                          Text("Privacy",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                        ],

                      ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.h,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage('assets/images/notification.png',),
                            ),
                          ),SizedBox(width: 8.w,),
                          Text("Notifications",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                        ],

                      ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.h,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage('assets/images/help.png',),
                            ),
                          ),SizedBox(width: 8.w,),
                          Text("Help",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                        ],

                      ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: (){
StorageUtil.clrAllString();
Navigator.pushNamed(context, '/welcome');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.h,
                            child: CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage('assets/images/logout.png',),
                            ),
                          ),SizedBox(width: 8.w,),
                          Text("Logout",style: GoogleFonts.poppins(fontSize:14.sp,fontWeight:FontWeight.w500,color:Colors.black))
                        ],

                      ),IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(height: 8.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
