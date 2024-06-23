class ApiResponse<T> {
  T data;
  String message;
  bool error;

  ApiResponse({required this.data, required this.message, required this.error});
  // Add more response handling as needed
}
