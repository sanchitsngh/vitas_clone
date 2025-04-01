import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/utils/global loader/global_loader.dart';
import '../../common/utils/validators.dart';
import '../../common/widgets/popup_messages.dart';
import 'notifier/sign_in_notifier.dart';

class SignInController {
  late WidgetRef ref;

  SignInController({required this.ref});

  void handleSignIn() async {
    var state = ref.read(signInNotifierProvider);
    String userEmail = state.email.trim();
    String password = state.password;

    // Check for empty fields

    if (userEmail.isEmpty) {
      toastInfo("Email cannot be empty");
      return;
    }

    if (password.isEmpty) {
      toastInfo("Password cannot be empty");
      return;
    }


    // Validate email
    if (!Validators.isValidEmail(userEmail)) {
      toastInfo("Please enter a valid email address");
      return;
    }

    // login logic

    // Show loader
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    var context =  Navigator.of(ref.context);

    Future.delayed(Duration(seconds: 3), () async {
      try {

        // Firebase authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userEmail, password: password);

        // If login is successful
        if (userCredential.user != null) {
          toastInfo("Success", backgroundColor: Colors.teal );
          // Navigate to homepage
          context.pushNamed("Home");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "too-many-requests") {
          toastInfo("Too many failed login attempts; try again later.");
        } else if (e.code == "user-disabled") {
          toastInfo("The user account has been disabled.");
        } else if (e.code == "user-not-found" || e.code == "wrong-password") {
          toastInfo("Invalid email or password.");
        } else {
          toastInfo("Authentication error: ${e.message}");
        }
      } catch (e) {
        toastInfo("Something went wrong: $e");
      } finally {
        // Hide loader after process is completed
        ref.read(appLoaderProvider.notifier).setLoaderValue(false);
      }
    });
  }
}
