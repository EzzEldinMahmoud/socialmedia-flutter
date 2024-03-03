import 'package:chatapp/cubit/socialcubit/socialcubit.dart';
import 'package:chatapp/cubit/socialcubit/socialstates.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,


              fixedColor: Colors.white,
              unselectedItemColor: Colors.white,
              backgroundColor: Colors.black,
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
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(Icons.settings,color: Colors.black,),
                ): Container(),

              ],
            ),
            body: Flex(
                direction:  Axis.vertical,
                children: [Expanded(
flex: 1,
                  child:
                    cubit.screens[cubit.currentindex],

                ),]
              )







           );
        },
      ));
  }
}
