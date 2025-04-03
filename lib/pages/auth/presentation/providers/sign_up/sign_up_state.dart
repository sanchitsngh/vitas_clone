class RegisterState {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String? userNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  RegisterState({
    this.userName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.userNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  RegisterState copyWith({
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
    String? userNameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return RegisterState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      userNameError: userNameError ?? this.userNameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
    );
  }
}