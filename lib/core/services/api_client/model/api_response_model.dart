class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool success;

  ApiResponse({this.data, this.message, this.success = false});

  factory ApiResponse.success(T data, [String? message]) {
    return ApiResponse(data: data, success: true, message: message);
  }

  factory ApiResponse.error(String message) {
    return ApiResponse(message: message, success: false);
  }
}
