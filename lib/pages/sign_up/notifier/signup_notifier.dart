import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitas_clone/pages/sign_up/notifier/sign_up_state.dart';
part 'signup_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void onUserNameChange(String name){
    state = state.copyWith(userName: name);
  }

  void onUserEmailChange(String email){
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password){
    state = state.copyWith(password: password);
  }

  void onUserConfirmPasswordChange(String confirmPassword){
    state = state.copyWith(confirmPassword: confirmPassword);
  }

}