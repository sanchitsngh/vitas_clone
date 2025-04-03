import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/global loader/provider/global_loader.dart';
import '../../../../common/widgets/popup_messages.dart';
import '../providers/google_auth/google_auth_notifier.dart';

class GoogleAuthController {
  final WidgetRef ref;
  final BuildContext context;

  GoogleAuthController({required this.ref, required this.context});

  Future<void> handleGoogleSignIn() async {
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    try {
      await ref.read(googleAuthNotifierProvider.notifier).signInWithGoogle();
      final state = ref.read(googleAuthNotifierProvider);

      if (state.errorMessage == null) {
        toastInfo("Google sign-in successful", backgroundColor: Colors.teal);
        Navigator.of(context).pushNamed("Home");
      } else {
        toastInfo(state.errorMessage!);
      }
    } finally {
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}