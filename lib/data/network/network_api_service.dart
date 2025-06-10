import 'dart:convert';
import 'dart:io';

import 'package:TourEase/data/app_exception.dart';
import 'package:TourEase/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class Networkapiservice extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse('')).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(''), body: data)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) {
    throw UnimplementedError();
  }

  @override
  Future getDeleteApiResponse(String url) {
    throw UnimplementedError();
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.statusCode.toString());
      case 404:
        throw UnauthorisedException(
            'Your request is not found, please try again later');

      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code: ${response.statusCode.toString()}');
    }
  }
}
