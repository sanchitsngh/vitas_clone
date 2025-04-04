import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/global loader/provider/global_loader.dart';
import '../../../../common/widgets/popup_messages.dart';
import '../../../../core/utils/validators.dart';
import '../providers/sign_up/signup_notifier.dart';

class SignUpController {
  late WidgetRef ref;

  SignUpController({required this.ref});

  bool isFormValid() {
    final state = ref.read(registerNotifierProvider);
    return state.userName.isNotEmpty &&
        Validators.isValidName(state.userName) &&
        state.email.isNotEmpty &&
        Validators.isValidEmail(state.email) &&
        state.password.isNotEmpty &&
        Validators.isValidPassword(state.password) &&
        state.confirmPassword.isNotEmpty &&
        state.password == state.confirmPassword;
  }

  void handleSignUp() async {
    final state = ref.read(registerNotifierProvider);
    String userName = state.userName.trim();
    String userEmail = state.email.trim();
    String password = state.password.trim();
    String confirmPassword = state.confirmPassword.trim();

    // Validation checks
    final notifier = ref.read(registerNotifierProvider.notifier);

    // Only validate if fields have been touched
    if (userName.isNotEmpty) {
      if (!Validators.isValidName(userName)) {
        notifier.setUserNameError("Only letters, digits (1-9), and special symbols \$, @, _ are allowed.");
      } else {
        notifier.setUserNameError(null);
      }
    }

    if (userEmail.isNotEmpty) {
      if (!Validators.isValidEmail(userEmail)) {
        notifier.setEmailError("Enter a valid email address");
      } else {
        notifier.setEmailError(null);
      }
    }

    if (password.isNotEmpty) {
      if (!Validators.isValidPassword(password)) {
        notifier.setPasswordError("Password must be at least 8 characters long, contain a number, and an uppercase letter");
      } else {
        notifier.setPasswordError(null);
      }
    }

    if (confirmPassword.isNotEmpty) {
      if (password != confirmPassword) {
        notifier.setConfirmPasswordError("Passwords do not match");
      } else {
        notifier.setConfirmPasswordError(null);
      }
    }

    if (!isFormValid()) {
      return;
    }

    // Proceed with Firebase request
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    var context = Navigator.of(ref.context);

    
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );
      toastInfo("Registered successfully", backgroundColor: Colors.teal);
      context.pushNamed("SignIn");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "The email address is already in use by another account.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password accounts are not enabled.";
          break;
        default:
          errorMessage = "An unexpected error occurred. Please try again.";
      }
      toastInfo(errorMessage);
    } catch (e) {
      toastInfo("Something went wrong. Please try again later.");
    } finally {
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}