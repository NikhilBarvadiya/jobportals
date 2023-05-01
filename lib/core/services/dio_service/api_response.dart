class APIResponse {
  dynamic message;
  dynamic data;
  dynamic status;

  APIResponse({required this.message, this.data, this.status});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      message: json['message'] as dynamic,
      data: json['data'] as dynamic,
      status: json['status'] as dynamic,
    );
  }
}
