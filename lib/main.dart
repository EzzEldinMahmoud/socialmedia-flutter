import 'package:chatapp/layout/forgot_password/forgotten_password_page.dart';
import 'package:chatapp/layout/nav_screen/bottom_navigation_screen.dart';
import 'package:chatapp/layout/register_screen/register_screen.dart';
import 'package:chatapp/layout/Search_screen/search_screen.dart';
import 'package:chatapp/layout/welcome_page/welcome_screen.dart';
import 'package:chatapp/layout/chat_screen/chat_screen.dart';
import 'package:chatapp/layout/create_post/create_post_screen.dart';
import 'package:chatapp/layout/login_screen/login_screen.dart';
import 'package:chatapp/layout/Messages_screen/messages_screen.dart';
import 'package:chatapp/shared/local/cachehelper.dart';
import 'package:chatapp/shared/remote/diohelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
import 'layout/Edit_profile/edit_profile.dart';
import 'layout/home_screen_folder/home_screen.dart';

Widget? widget;
void main() async{


  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
);
//firebase cloud messaging for notification
var token = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print(token);
      }
      FirebaseMessaging.onMessage.listen((event) {
        if (kDebugMode) {
          print(event.data.toString());
        }
      });

  await StorageUtil.getInstance();
  await diohelper.init();
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  var uid = StorageUtil.getString('uid');
  if(uid.isEmpty){
    widget = const WelcomePage();
  }else{
    widget = const MainScreen();
  }
  runApp(const MyApp());
}



final Map<String, Widget Function(BuildContext)> routes = {
  '/': (BuildContext context) => widget ?? const WelcomePage(),
  '/main': (BuildContext context) => const MainScreen(),
  '/home': (BuildContext context) => const Homescreen(),
  '/login': (BuildContext context) => const LOGINSCREEN(),
  '/register': (BuildContext context) => const RegisterScreen(),
  '/editprofile': (BuildContext context) => const EditProfile(),
  '/createpost': (BuildContext context) => const CREATEPOST(),
  '/chat': (BuildContext context) => const CHATSCREEN(),
  '/search': (BuildContext context) => const SearchPage(),
  '/messagescreen': (BuildContext context) => const Messagesscreen(),
  '/welcome': (BuildContext context) => const WelcomePage(),
  '/resetpassword': (BuildContext context) => const PasswordReset(),



};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (BuildContext context) { return Socialappcubit(SocialappHOMEinitialstate()); },)
      ,BlocProvider(create: (BuildContext context) { return appcubit(appinitialstate()); },)
      ],
      child:BlocConsumer<appcubit, appstate>(
          listener: (context, state) {},
          builder: (context, state) {
            return ScreenUtilInit(
                designSize:  const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: false,
// Use builder only if you need to use library outside ScreenUtilInit context
                builder: (ctx, child) {

                  return MaterialApp(
                    themeMode: ThemeMode.light,
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
