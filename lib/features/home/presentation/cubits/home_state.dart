class HomeState {
  final bool isLoading;
  final bool fetchSuccess;
  final String? errorMessage;
  final bool shouldRequestLocation;

  HomeState({
    this.isLoading = false,
    this.errorMessage = '',
    this.shouldRequestLocation = false,
    this.fetchSuccess = false,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? shouldRequestLocation,
    bool? fetchSuccess,
  }) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    shouldRequestLocation: shouldRequestLocation ?? this.shouldRequestLocation,
    fetchSuccess: fetchSuccess ?? this.fetchSuccess,
  );
}
