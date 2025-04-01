import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/utils/global loader/global_loader.dart';
import '../../common/utils/validators.dart';
import '../../common/widgets/popup_messages.dart';
import 'notifier/signup_notifier.dart';


class SignUpController {
  late WidgetRef ref;

  SignUpController({required this.ref});

  void handleSignUp() async {
    var state = ref.read(registerNotifierProvider);
    String userName = state.userName.trim();
    String userEmail = state.email.trim();
    String password = state.password;
    String confirmPassword = state.confirmPassword;

    // Check for empty fields
    if (userName.isEmpty) {
      toastInfo("Name cannot be empty");
      return;
    }

    if (userEmail.isEmpty) {
      toastInfo("Email cannot be empty");
      return;
    }

    if (password.isEmpty) {
      toastInfo("Password cannot be empty");
      return;
    }

    if (confirmPassword.isEmpty) {
      toastInfo("Confirm Password cannot be empty");
      return;
    }

    // Validate name
    if (!Validators.isValidName(userName)) {
      toastInfo("Only letters, digits (1-9), and special symbols \$, @, _ are allowed.");
      return;
    }

    // Validate email
    if (!Validators.isValidEmail(userEmail)) {
      toastInfo("Please enter a valid email address");
      return;
    }

    // Validate password
    if (!Validators.isValidPassword(password)) {
      toastInfo("Password must be at least 8 characters long, contain a number, and an uppercase letter");
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      toastInfo("Passwords must be the same");
      return;
    }

    //registration logic
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    var context =  Navigator.of(ref.context);
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        // Firebase authentication
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: password);
        // If login is successful
        if(credential.user != null){
          await credential.user?.sendEmailVerification();
          await credential.user?.updateDisplayName(userName);
          toastInfo("An Email has been sent to verify your account. Please open the email and verify it.", backgroundColor: Colors.teal);
          // Navigate to SignIn page
          context.pop();
        }
      } on FirebaseAuthException catch(e) {
        if(e.code == "weak-password"){
          toastInfo("The password is too weak");
        } else if(e.code == "email-already-in-use") {
          toastInfo("This email address has already been registered");
        } else if(e.code == "user-disabled") {
          toastInfo("The user account has been disabled.");
        } else {
          toastInfo("Authentication error: ${e.message}");
        }
      } catch(e) {
        toastInfo("something went wrong");
        ref.read(appLoaderProvider.notifier).setLoaderValue(false);
      }
      finally {
        // Hide loader after process is completed
        ref.read(appLoaderProvider.notifier).setLoaderValue(false);
      }
    });
  }
}
