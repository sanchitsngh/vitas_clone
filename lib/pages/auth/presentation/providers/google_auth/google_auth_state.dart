class GoogleAuthState {
  final bool isLoading;
  final String? errorMessage;

  GoogleAuthState({
    this.isLoading = false,
    this.errorMessage,
  });

  GoogleAuthState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return GoogleAuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}