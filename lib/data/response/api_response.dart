import 'package:TourEase/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  bool? error;

  ApiResponse(
      {required this.data,
      required this.status,
      required this.message,
      required this.error});
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMPLETED;
  ApiResponse.error() : status = Status.ERROR;

  @override
  String toString() {
    return "Status:$status \n Message : $message \n Data : $data \n Error : $error";
  }
}
