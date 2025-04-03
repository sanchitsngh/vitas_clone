import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/utils/validators.dart';
import 'forgot_password_state.dart';

part 'forgot_password_notifier.g.dart';

@riverpod
class ForgotPasswordNotifier extends _$ForgotPasswordNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  ForgotPasswordState build() => ForgotPasswordState();

  void updateEmail(String email) {
    state = state.copyWith(email: email, emailError: null);
  }

  Future<void> sendResetEmail() async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);

    // Validation
    if (state.email.isEmpty || !Validators.isValidEmail(state.email)) {
      state = state.copyWith(
        emailError: "Please enter a valid email",
        isLoading: false,
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: state.email);
      state = state.copyWith(
        successMessage: "Password reset email sent successfully",
        isLoading: false,
      );
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
    } catch (e) {
      state = state.copyWith(
        errorMessage: "Unexpected error: ${e.toString()}",
        isLoading: false,
      );
    }
  }

  void _handleFirebaseError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = "No account found with this email";
        break;
      case 'invalid-email':
        message = "Invalid email address";
        break;
      case 'too-many-requests':
        message = "Too many requests. Try again later";
        break;
      default:
        message = "Failed to send reset email: ${e.message}";
    }
    state = state.copyWith(errorMessage: message, isLoading: false);
  }
}