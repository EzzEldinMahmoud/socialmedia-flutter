import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return  Socialappcubit(SocialappHOMEinitialstate())..getPosts()..getUserData()..getusers(); },

      child: BlocConsumer<Socialappcubit, socialappstate>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Socialappcubit.get(context);
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title:  Text(cubit.titles[cubit.currentindex]),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: const Icon(Icons.search),
                ),
                cubit.titles[cubit.currentindex] == "Settings" ?  IconButton(
                  onPressed: () {
                    StorageUtil.clrString('uid');
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout,color: Colors.red,),
                ): Container(),
              ],
            ),
            body: Stack(
              children:[Flex(
                direction:  Axis.vertical,
                children: [Expanded(

                  child:
                    cubit.screens[cubit.currentindex],

                ),]
              )
              ,Align(
                  alignment: Alignment.bottomCenter,

                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                  child: Container(


                    foregroundDecoration: const BoxDecoration(
                     color: Colors.transparent,

                    ),
                    decoration:  BoxDecoration(

                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,


                      fixedColor: Colors.white,
                      unselectedItemColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      currentIndex: cubit.currentindex,
                      onTap: (index) {
                        cubit.changeindex(index);
                      },
                      items:   [
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.chat),
                          label: 'Chats',
                        ),
                        BottomNavigationBarItem(
                          icon: IconButton(
                              icon:const Icon(Icons.add_box)
                              , onPressed: () { Navigator.pushNamed(context, '/createpost'); },),
                          label: 'Create Post',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          label: 'Market Place',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              ],
            )



           );
        },
      ));
  }
}
