import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/global loader/provider/global_loader.dart';
import '../../../../common/widgets/popup_messages.dart';
import '../providers/forgot_password/forgot_password_notifier.dart';

class ForgotPasswordController {
  final WidgetRef ref;
  final BuildContext context;

  ForgotPasswordController({required this.ref, required this.context});

  void handleEmailUpdate(String email) {
    ref.read(forgotPasswordNotifierProvider.notifier).updateEmail(email);
  }

  Future<void> handleSendResetEmail() async {
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    try {
      await ref.read(forgotPasswordNotifierProvider.notifier).sendResetEmail();
      final state = ref.read(forgotPasswordNotifierProvider);

      if (state.successMessage != null) {
        toastInfo(state.successMessage!, backgroundColor: Colors.teal);
        Navigator.pop(context);
      } else if (state.errorMessage != null) {
        toastInfo(state.errorMessage!);
      }
    } finally {
      ref.read(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }
}