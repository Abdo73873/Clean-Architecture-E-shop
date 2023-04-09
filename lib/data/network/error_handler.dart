import 'package:dio/dio.dart';
import 'package:mena/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(error) {
    if (error is DioError) {
      failure = _handleDioError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioErrorType.badCertificate:
      return DataSource.BAD_REQUEST.getFailure();
    case DioErrorType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
            error.response!.statusCode!, error.response!.statusMessage!);
      }
      else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioErrorType.unknown:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtantion on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int NOT_FOUND = 404; //  failure, not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1; //
  static const int CANCEL = -2; //
  static const int RECIEVE_TIMEOUT = -3; //
  static const int SEND_TIMEOUT = -4; //
  static const int CACHE_ERROR = -5; //
  static const int NO_INTERNET_CONNECTION = -6; //
  static const int DEFAULT = -7; //
}

class ResponseMessage {
  static const String SUCCESS = "success with data";
  static const String NO_CONTENT = 'success with no data (no content)';
  static const String BAD_REQUEST = 'bad request, try again later';
  static const String UNAUTORISED = 'UN authorised, try again later';
  static const String FORBIDDEN = 'forbidden authorised, try again later';
  static const String NOT_FOUND = 'some thing went wrong, try again later';
  static const String INTERNAL_SERVER_ERROR =
      'some thing went wrong, try again later';

  //local status code
  static const String CONNECT_TIMEOUT = 'Time out error , try again later';
  static const String CANCEL = 'Request was cancelled, try again later';
  static const String RECIEVE_TIMEOUT = 'Time out error , try again later';
  static const String SEND_TIMEOUT = 'Time out error , try again later';
  static const String CACHE_ERROR = 'Cache error , try again later';
  static const String NO_INTERNET_CONNECTION =
      'please check your internet connection';
  static const String DEFAULT = 'some thing went wrong, try again later';
}

class ApiInternalStatus{
  static const int SCUSSUS=0;
  static const int FAILURE=1;
}