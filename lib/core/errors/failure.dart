import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  Failures(this.errorMessage);
}



class ServerFailure extends Failures {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connection Timeout with Api Service');

      case DioExceptionType.sendTimeout:
        return ServerFailure('send Timeout with Api Service');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive Timeout with Api Service');
      case DioExceptionType.badCertificate:
        return ServerFailure('connection Timeout with Api Service');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to  Api Service was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet connection');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, please try again!');
      default: return ServerFailure('Opps there was an error, please try again');

    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found,please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error , please try later');
    } else {
      return ServerFailure('Opps there was an error!, please try again');
    }
  }
}