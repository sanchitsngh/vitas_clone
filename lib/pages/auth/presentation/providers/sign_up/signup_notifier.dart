import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitas_clone/pages/auth/presentation/providers/sign_up/sign_up_state.dart';
part 'signup_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void onUserNameChange(String name) {
    state = state.copyWith(userName: name, userNameError: null);
  }

  void onUserEmailChange(String email) {
    state = state.copyWith(email: email, emailError: null);
  }

  void onUserPasswordChange(String password) {
    state = state.copyWith(password: password, passwordError: null);
  }

  void onUserConfirmPasswordChange(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword, confirmPasswordError: null);
  }

  // Error setters
  void setUserNameError(String? error) {
    state = state.copyWith(userNameError: error);
  }

  void setEmailError(String? error) {
    state = state.copyWith(emailError: error);
  }

  void setPasswordError(String? error) {
    state = state.copyWith(passwordError: error);
  }

  void setConfirmPasswordError(String? error) {
    state = state.copyWith(confirmPasswordError: error);
  }
}