import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fruit_app/Service/shared_pref.dart';
import 'package:fruit_app/firebase_options.dart';
import 'package:fruit_app/generated/l10n.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/Login/login_screen.dart';
import 'package:fruit_app/modules/splash/splash_screen.dart';
import 'package:fruit_app/shared/bloc_observer.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ywjzourlwwrtnksnlbri.supabase.co',
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl3anpvdXJsd3dydG5rc25sYnJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5MjM4NTQsImV4cCI6MjA0OTQ5OTg1NH0.r1tM7CRi1HTYHQGYAXEHEKEZN-ScmcaxzuW8FrH2Mkw",
  );
  Bloc.observer = MyBlocObserver();
  await SharedPrefrencesSingleton.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Widget widget;
  print(uId);
  uId = SharedPrefrencesSingleton.getData(key: 'uId');
  // if (uId != null) {
  //   widget = FruitappLayout();
  // } else {
  //   widget = LoginScreen();
  // }
  if (uId != null) {
    final session = await Supabase.instance.client.auth.refreshSession();
    if (session.session == null || session.session!.accessToken.isEmpty) {
      print('Error refreshing session');
    } else {
      print('Session refreshed successfully!');
    }
  }
  widget = SplashScreen();
  print(uId);
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FruitAppCubit()
        ..getUserData()
        ..getProductsData()
        ..getCartItems(),
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Cairo',
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor)),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale("ar"),
        home: startWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
