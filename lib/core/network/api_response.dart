/// Generic class for handling API responses
/// [T] - Type of the data payload
/// [status] - API status (e.g., "success", "error")
/// [message] - Human-readable message
/// [data] - The actual payload data
/// [fromJsonT] - Function to convert the payload data to the desired type
///
class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;

  ApiResponse({required this.status, required this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json.containsKey('status') ? json['status'] : '',
      message: json.containsKey('message') ? json['message'] : '',
      data: (json.containsKey(key) && json[key] != null)
          ? fromJsonT(json[key] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() =>
      'ApiResponse(status: $status, message: $message, data: $data)';
}
