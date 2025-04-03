class ForgotPasswordState {
  final String email;
  final String? emailError;
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  ForgotPasswordState({
    this.email = '',
    this.emailError,
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    String? email,
    String? emailError,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}