class ErrorResponse {

  int? code;
  bool? status;
  String? message;

  ErrorResponse({ this.message,this.status,this.code});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
  }

}
