import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fruit_app/Service/DioHelper.dart';
import 'package:fruit_app/Service/shared_pref.dart';
import 'package:fruit_app/firebase_options.dart';
import 'package:fruit_app/generated/l10n.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/login_screen.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/verfication/verification_screen.dart';
import 'package:fruit_app/modules/splash/splash_screen.dart';
import 'package:fruit_app/shared/bloc_observer.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ywjzourlwwrtnksnlbri.supabase.co',
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl3anpvdXJsd3dydG5rc25sYnJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5MjM4NTQsImV4cCI6MjA0OTQ5OTg1NH0.r1tM7CRi1HTYHQGYAXEHEKEZN-ScmcaxzuW8FrH2Mkw",
  );
  await Diohelper.initDio();
  Bloc.observer = MyBlocObserver();
  await SharedPrefrencesSingleton.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Widget startWidget = SplashScreen();
  uId = SharedPrefrencesSingleton.getData(key: 'uId');

  if (uId != null) {
    final session = await Supabase.instance.client.auth.refreshSession();
    if (session.session == null || session.session!.accessToken.isEmpty) {
      print('Error refreshing session');
    } else {
      print('Session refreshed successfully!');
    }
  }

  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatefulWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _handleInitialAppLink();
    _initDeepLinkListener();
  }

  Future<void> _handleInitialAppLink() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      print("Error getting initial app link: $e");
    }
  }

  void _initDeepLinkListener() {
    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      print("Deep Link Error: $err");
    });
  }

  void _handleDeepLink(Uri uri) {
    if (uri.host == "password-reset") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VerificationScreen(),
      ));
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FruitAppCubit()
        ..getProductsData()
        ..getUserData()
        ..getCartItems()
        ..getAuthToken()
        ..getOrdersData()
        ..getPaymentCreditCardData()
        ..getFavouritesData(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Cairo',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale("ar"),
        home: widget.startWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
