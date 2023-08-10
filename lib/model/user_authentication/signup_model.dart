class SignupResponse {
  late bool status;
  late String message;
  late dynamic error;
  late SignupData data;

  SignupResponse(
      {required this.status,
      required this.message,
      required this.error,
      required this.data});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    data = (json['data'] != null ? SignupData.fromJson(json['data']) : null)!;
  }
}

class SignupData {
  late int id;
  late String fullName;
  late String mobile;
  late dynamic email;

  SignupData(
      {required this.id,
      required this.fullName,
      required this.mobile,
      this.email});

  SignupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    email = json['email'];
  }
}
