// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthResponseModel {
  bool isSuccess;
  String message;
  dynamic data;
  AuthResponseModel({
    required this.isSuccess,
    required this.message,
    this.data,
  });
}
