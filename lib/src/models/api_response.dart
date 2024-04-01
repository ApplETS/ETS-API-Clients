class ApiResponse<T> {
  final T? data;
  final String? error;

  ApiResponse({this.data, this.error});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'data': data != null ? toJsonT(data!) : null,
      'error': error,
    };
  }
}
