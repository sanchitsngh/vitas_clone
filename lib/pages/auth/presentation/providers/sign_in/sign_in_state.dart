import '../../../../../core/utils/validators.dart';

class SignInState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;

  SignInState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  // Check if the form is valid
  bool get isValid {
    return email.isNotEmpty &&
        Validators.isValidEmail(email) &&
        password.isNotEmpty &&
        password.length >= 6;
  }
}