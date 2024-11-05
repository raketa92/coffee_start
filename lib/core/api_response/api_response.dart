class ApiResponseList<Model> {
  final List<Model> result;

  ApiResponseList({required this.result});

  factory ApiResponseList.fromJson(Map<String, dynamic> json,
      Model Function(Map<String, dynamic>) fromJson) {
    return ApiResponseList(
      result: (json['result'] as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ApiResponse<Model> {
  final Model result;

  ApiResponse({required this.result});

  factory ApiResponse.fromJson(Map<String, dynamic> json,
      Model Function(Map<String, dynamic>) fromJson) {
    return ApiResponse(
        result: fromJson(json['result'] as Map<String, dynamic>));
  }
}
