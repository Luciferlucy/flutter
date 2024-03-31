
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/layout/shop_App/cubit/cubit.dart';
import 'package:untitled/layout/shop_App/shop_layout.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:untitled/modules/social_app/social_login/cubit/cubit.dart';
import 'package:untitled/shared/Network/local/cache_helper.dart';
import 'package:untitled/shared/Network/remote/dio_helper.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubic/cubit.dart';
import 'package:untitled/shared/cubic/states.dart';
import 'package:untitled/shared/styles/themes.dart';
import 'package:window_manager/window_manager.dart';

import 'desktop.dart';
import 'layout/home_layout.dart';
import 'layout/news_App/cubit/cubit.dart';
import 'layout/news_App/news_layout.dart';
import 'modules/social_app/social_login/social_login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler (RemoteMessage message) async{
  print(message.data.toString());
  ShowToastt(text: 'on message background', state: ToastStates.Success);

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isWindows){
    await WindowOptions(
      size: Size(650, 650),
    );
  }
  await Firebase.initializeApp();
  var tokenn =await  FirebaseMessaging.instance.getToken();
  print("token is ${tokenn.toString()}");
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    ShowToastt(text: 'on message', state: ToastStates.Success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    ShowToastt(text: 'on message opened app', state: ToastStates.Success);

  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool? isDark = CasheHelper.Getdata(key: 'isDark');
  Widget widget;
  //bool? onBoarding = CasheHelper.Getdata(key: 'onBoarding');
  //token = CasheHelper.Getdata(key: 'token');
  var  uId = CasheHelper.Getdata(key: 'uId');

  //print(token);
  // if (onBoarding != null){
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // }else{ widget = OnBoardingScreen();}
  if(uId != null){
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    isDark,widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startwidget;
  MyApp(
     this.isDark,
     this.startwidget,
      );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getScience()..getSports()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        )),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),),
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUserData()..getPost()),
      ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener:(context ,state) {} ,
          builder: (context ,state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false ,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home:startwidget

              //NewsLayout
            );
          },
        ),
      );

  }
}

