import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/pages/homepage/homepage.dart';
import 'package:vitas_clone/pages/referral/referral.dart';
import 'package:vitas_clone/pages/sign_in/sign_in.dart';
import 'package:vitas_clone/pages/sign_up/sign_up.dart';
import 'package:vitas_clone/pages/webinars/webinars.dart';
import 'package:vitas_clone/pages/welcome/welcome.dart';
import 'common/utils/app_styles.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized only once
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.appThemeData,
          initialRoute: "/",
          routes: {
            "SignIn": (context) => SignIn(),
            "Register": (context) => SignUp(),
            "Home": (context) => Homepage(),
            "Webinars": (context) => Webinars(),
            "Referrals": (context) => Referral(),
          },
          home: Welcome(),
        );
      },
    );
  }
}
