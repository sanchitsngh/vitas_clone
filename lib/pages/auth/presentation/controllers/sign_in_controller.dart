import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/core/utils/validators.dart';
import '../../../../common/utils/global loader/provider/global_loader.dart';
import '../../../../common/widgets/popup_messages.dart';
import '../providers/sign_in/sign_in_notifier.dart';

class SignInController {
  final WidgetRef ref;
  final BuildContext context;

  SignInController({required this.ref, required this.context});

  void handleSignIn() async {
    var state = ref.read(signInNotifierProvider);
    String userEmail = state.email.trim();
    String password = state.password;

    // Validation checks
    bool isValid = true;
    final notifier = ref.read(signInNotifierProvider.notifier);

    // Email validation
    if (userEmail.isEmpty) {
      notifier.setEmailError("Email is required");
      isValid = false;
    } else if (!Validators.isValidEmail(userEmail)) {
      notifier.setEmailError("Please enter a valid email");
      isValid = false;
    } else {
      notifier.setEmailError(null);
    }

    // Password validation
    if (password.isEmpty) {
      notifier.setPasswordError("Password is required");
      isValid = false;
    } else if (password.length < 6) {
      notifier.setPasswordError("Password must be at least 6 characters long");
      isValid = false;
    } else {
      notifier.setPasswordError(null);
    }

    if (!isValid) {
      return;
    }

    // Show loader
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      // Firebase authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: password);

      // If login is successful
      if (userCredential.user != null) {
        toastInfo("Success", backgroundColor: Colors.teal);
        // Navigate to homepage
        Navigator.of(context).pushNamed("Home");
      }
    }  on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'too-many-requests':
          errorMessage = "Too many failed login attempts. Try again later";
          break;
        case 'user-disabled':
          errorMessage = "The user account has been disabled.";
          break;
        case 'user-not-found':
        case 'wrong-password':
          errorMessage = "Invalid email or password.";
          break;
        case 'invalid-credential':
          errorMessage = "Invalid credentials. Please try again.";
          break;
        default:
          errorMessage = "Unexpected error: ${e.code}";
      }
      toastInfo(errorMessage);
    } catch (e) {
      toastInfo("Something went wrong: $e");
    } finally {
      // Hide loader after process is completed
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}