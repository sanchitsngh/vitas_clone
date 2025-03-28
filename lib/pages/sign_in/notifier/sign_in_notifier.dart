import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitas_clone/pages/sign_in/notifier/sign_in_state.dart';
part 'sign_in_notifier.g.dart';


@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    return SignInState();
  }

  void onUserEmailChange(String email){
    state = state.copyWith(email: email);
  }

  void onUserPasswordChange(String password){
    state = state.copyWith(password: password);
  }

}