import 'package:chatapp/layout/EditProfile.dart';
import 'package:chatapp/layout/Homescreen.dart';
import 'package:chatapp/layout/MainScreen.dart';
import 'package:chatapp/layout/Register.dart';
import 'package:chatapp/layout/SearchPage.dart';
import 'package:chatapp/layout/WelcomeScreen.dart';
import 'package:chatapp/layout/chatscreen.dart';
import 'package:chatapp/layout/createPOST.dart';
import 'package:chatapp/layout/login.dart';
import 'package:chatapp/layout/messagescreen.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:chatapp/shared/remote/diohelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/apptheme.dart';
import 'cubit/BlocObserver.dart';
import 'cubit/cubit.dart';
import 'cubit/socialcubit/socialcubit.dart';
import 'cubit/socialcubit/socialstates.dart';
import 'cubit/states.dart';
import 'firebase_options.dart';

Widget? widget;
void main() async{


  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
);
  await StorageUtil.getInstance();
  await diohelper.init();
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  var uid = StorageUtil.getString('uid');
  if(uid.isEmpty){
    widget = WelcomePage();
  }else{
    widget = MainScreen();
  }
  print(uid);
  runApp(const myapp());
}



final Map<String, Widget Function(BuildContext)> routes = {
  '/': (BuildContext context) => widget ?? WelcomePage(),
  '/main': (BuildContext context) => MainScreen(),
  '/home': (BuildContext context) => Homescreen(),
  '/login': (BuildContext context) => LOGINSCREEN(),
  '/register': (BuildContext context) => RegisterScreen(),
  '/editprofile': (BuildContext context) => EditProfile(),
  '/createpost': (BuildContext context) => CREATEPOST(),
  '/chat': (BuildContext context) => CHATSCREEN(),
  '/search': (BuildContext context) => SearchPage(),


  '/messagescreen': (BuildContext context) => Messagesscreen(),


};

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (BuildContext context) { return Socialappcubit(SocialappHOMEinitialstate()); },)
      ,BlocProvider(create: (BuildContext context) { return appcubit(appinitialstate()); },)
      ],
      child:BlocConsumer<appcubit, appstate>(
          listener: (context, state) {},
          builder: (Context, State) {
            return ScreenUtilInit(
                designSize:  Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: false,
// Use builder only if you need to use library outside ScreenUtilInit context
                builder: (ctx, child) {

                  return MaterialApp(
                    themeMode: ThemeMode.dark,
                    theme: lighttheme,
                    initialRoute: '/',
                    darkTheme: darktheme,
                    debugShowCheckedModeBanner: false,
                    routes: routes,
                  );
                });
          }
      )
    );
   }
}
