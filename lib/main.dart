import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitas_clone/pages/auth/presentation/pages/forgot_password_page.dart';
import 'package:vitas_clone/pages/homepage/homepage.dart';
import 'package:vitas_clone/pages/referral/referral.dart';
import 'package:vitas_clone/pages/auth/presentation/pages/sign_in_page.dart';
import 'package:vitas_clone/pages/auth/presentation/pages/sign_up_page.dart';
import 'package:vitas_clone/pages/webinars/webinars.dart';
import 'package:vitas_clone/pages/welcome/welcome.dart';
import 'core/config/firebase_options.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_styles.dart';

// Add auth state provider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.appThemeData,
          //Modify home based on auth state
          home: authAsync.when(
            data: (user) => user != null ? Homepage() : Welcome(),
            loading: () => Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryElement,
                ),
              ),
            ),
            error: (error, stack) => ErrorScreen(error: error.toString()),
          ),
          routes: {
            "SignIn": (context) => SignIn(),
            "Register": (context) => SignUp(),
            "Home": (context) => Homepage(),
            "Webinars": (context) => Webinars(),
            "Referrals": (context) => Referral(),
            "ForgotPassword": (context) => ForgotPasswordPage(),
          },
        );
      },
    );
  }
}

// Add error screen widget
class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error', style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}