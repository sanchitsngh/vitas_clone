import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitas_clone/pages/auth/presentation/providers/sign_in/sign_in_state.dart';
part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    return SignInState();
  }

  void onUserEmailChange(String email) {
    state = state.copyWith(email: email, emailError: null); // Clear error
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password, passwordError: null); // Clear error
  }

  // Error setters
  void setEmailError(String? error) {
    state = state.copyWith(emailError: error);
  }

  void setPasswordError(String? error) {
    state = state.copyWith(passwordError: error);
  }
}