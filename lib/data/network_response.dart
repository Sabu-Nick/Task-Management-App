class NetworkResponse {
  final bool isSuccess;
  final int? statusCode;
  final dynamic responseData;
  final String? errorMessages;

  NetworkResponse({
    required this.isSuccess,
    this.statusCode,
    this.responseData,
    this.errorMessages = 'Something is wrong',
  });
}
