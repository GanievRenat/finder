import 'package:dio/dio.dart';

abstract class ApiException {
  const ApiException();
}

class BaseApiException extends DioException implements ApiException {
  BaseApiException({
    required DioException dioError,
    required this.errorCode,
    this.details,
  }) : super(
         requestOptions: dioError.requestOptions,
         response: dioError.response,
         type: dioError.type,
         error: dioError.error,
       );

  /// Server-specific error code
  final String errorCode;

  /// Detailed debug info.
  final String? details;

  static Future<BaseApiException> parse(
    DioException dioError, {
    required Future<bool> Function() checkHasConnection,
  }) async {
    final errorBody = await _tryReadErrorBody(dioError.response);
    if (errorBody case {'error': final String errorType}) {
      return _resolveApiException(
        errorType: errorType,
        errorDetails: null,
        data: null,
        dioError: dioError,
      );
    }

    if (errorBody case {'errors': final Map<String, dynamic> errors}) {
      if (errors.keys.contains('code') && errors.keys.contains('message')) {
        return _resolveApiException(
          errorType: (errors['code'] as int).toString(),
          errorDetails: errors['message'] as String?,
          data: null,
          dioError: dioError,
        );
      }
    }

    if (errorBody case {'errors': final List<dynamic> errors}) {
      if (errors.first is! Map) {
        return BaseApiException(
          dioError: dioError,
          errorCode: 'unknown',
          details: 'Unknown error',
        );
      }

      final refactoredErrorsList = errors
          .map(
            (element) => element['code'] != null
                ? _resolveApiException(
                    errorType: (element['code'] as int).toString(),
                    errorDetails: element['message'] as String?,
                    data: null,
                    dioError: dioError,
                  )
                : BaseApiException(
                    dioError: dioError,
                    errorCode: 'unknown',
                    details: 'Unknown error',
                  ),
          )
          .first;

      return refactoredErrorsList;
    }

    if (errorBody case {'errors': final Map<String, dynamic> errors}) {
      if (errors.containsKey('code') && errors.containsKey('message')) {
        return _resolveApiException(
          errorType: (errors['code'] as int).toString(),
          errorDetails: errors['message'] as String?,
          data: null,
          dioError: dioError,
        );
      }

      return BaseApiException(
        dioError: dioError,
        errorCode: 'unknown',
        details: 'Unknown error',
      );
    }

    if (errorBody case {'code': final int errorType}) {
      final data = errorBody['data'] as Map<String, dynamic>?;
      final errorDetails = data?['message'] as String?;

      return _resolveApiException(
        errorType: errorType.toString(),
        errorDetails: errorDetails,
        data: data,
        dioError: dioError,
      );
    }

    final statusCode = dioError.response?.statusCode;
    if (statusCode == 500) {
      return InternalError(dioError: dioError);
    }

    if (statusCode == 403) {
      return UserCreateException(dioError: dioError);
    }

    final hasConnection = await checkHasConnection();
    if (!hasConnection) {
      return NetworkConnectionException(dioError: dioError);
    }

    return BaseApiException(
      dioError: dioError,
      errorCode: 'unknown',
      details: 'Unknown error',
    );
  }

  static Future<Map<String, dynamic>?> _tryReadErrorBody(
    Response<dynamic>? response,
  ) async {
    final data = response?.data;
    if (data == null) {
      return null;
    } else if (data is Map<String, dynamic>) {
      return data;
    }
    return null;
  }

  static BaseApiException _resolveApiException({
    required String errorType,
    required String? errorDetails,
    required Map<String, dynamic>? data,
    required DioException dioError,
  }) {
    switch (errorType) {
      case 'User not found':
        return UserNotFoundException(dioError: dioError, details: errorDetails);
      case '666':
        return FailedToConnectToService(
          dioError: dioError,
          details: errorDetails,
        );
      case 'token invalid':
        return InvalidTokenException(dioError: dioError);
      case '12126':
        return UserNotFoundException(dioError: dioError, details: errorDetails);
      case '12127':
        return EmailNotValidException(
          dioError: dioError,
          details: errorDetails,
        );
      case '1104':
        return InvalidOtpException(dioError: dioError, details: errorDetails);
      case '1105':
        return OtpLargeNumberOfAttemptsException(
          dioError: dioError,
          details: errorDetails,
        );
      case '1106':
        return OtpTokenExpiredException(
          dioError: dioError,
          details: errorDetails,
        );
      case '1203':
        return InvalidPasswordException(
          dioError: dioError,
          details: errorDetails,
        );
      case '12125':
        return InvalidTokenException(dioError: dioError, details: errorDetails);
      case '1003':
        return UserAlreadyExistsException(
          dioError: dioError,
          details: errorDetails,
        );
      case '1170':
        return InvalidIdException(dioError: dioError, details: errorDetails);
      case '2700':
        return NoPlacesException(dioError: dioError, details: errorDetails);
      case '2900':
        return NotPilotException(dioError: dioError, details: errorDetails);
      case '2990':
        return EmptyProfileException(dioError: dioError, details: errorDetails);
      case '2901':
        return NotApprovedException(dioError: dioError, details: errorDetails);
      case '3210':
        return AlreadyJoinedException(
          dioError: dioError,
          details: errorDetails,
        );
      case '12128':
        return UserCreateException(dioError: dioError, details: errorDetails);
      default:
        return BaseApiException(
          dioError: dioError,
          errorCode: errorType,
          details: errorDetails,
        );
    }
  }
}

class PasswordMustMatchException extends BaseApiException {
  PasswordMustMatchException({
    required super.dioError,
    super.errorCode = 'The new password must match.',
    super.details,
  });
}

class InternalError extends BaseApiException {
  InternalError({
    required super.dioError,
    super.errorCode = '500',
    super.details,
  });
}

class NetworkConnectionException extends BaseApiException {
  NetworkConnectionException({
    required super.dioError,
    super.errorCode = 'network-connection',
    super.details,
  });
}

class InvalidTokenException extends BaseApiException {
  InvalidTokenException({
    required super.dioError,
    super.errorCode = '12125',
    super.details,
  });
}

class UserCreateException extends BaseApiException {
  UserCreateException({
    required super.dioError,
    super.errorCode = '12128',
    super.details,
  });
}

class UserNotFoundException extends BaseApiException {
  /// user_not_found
  UserNotFoundException({
    required super.dioError,
    super.errorCode = '12126',
    super.details,
  });
}

class NoPlacesException extends BaseApiException {
  /// no_places
  NoPlacesException({
    required super.dioError,
    super.errorCode = '2700',
    super.details,
  });
}

class NotPilotException extends BaseApiException {
  /// not_pilot
  NotPilotException({
    required super.dioError,
    super.errorCode = '2900',
    super.details,
  });
}

class EmptyProfileException extends BaseApiException {
  /// empty_profile
  EmptyProfileException({
    required super.dioError,
    super.errorCode = '2990',
    super.details,
  });
}

class AlreadyJoinedException extends BaseApiException {
  /// already_joined_this_application
  AlreadyJoinedException({
    required super.dioError,
    super.errorCode = '3210',
    super.details,
  });
}

class NotApprovedException extends BaseApiException {
  /// not_approved
  NotApprovedException({
    required super.dioError,
    super.errorCode = '2901',
    super.details,
  });
}

class EmailNotValidException extends BaseApiException {
  /// email_not_valid
  EmailNotValidException({
    required super.dioError,
    super.errorCode = '12127',
    super.details,
  });
}

class InvalidOtpException extends BaseApiException {
  /// invalid_otp
  InvalidOtpException({
    required super.dioError,
    super.errorCode = '1104',
    super.details,
  });
}

class OtpLargeNumberOfAttemptsException extends BaseApiException {
  /// otp_large_number_of_attempts
  OtpLargeNumberOfAttemptsException({
    required super.dioError,
    super.errorCode = '1105',
    super.details,
  });
}

class OtpTokenExpiredException extends BaseApiException {
  /// otp_expired
  OtpTokenExpiredException({
    required super.dioError,
    super.errorCode = '1106',
    super.details,
  });
}

class InvalidPasswordException extends BaseApiException {
  /// invalid_password
  InvalidPasswordException({
    required super.dioError,
    super.errorCode = '1203',
    super.details,
  });
}

class UserAlreadyExistsException extends BaseApiException {
  /// user_already_exists
  UserAlreadyExistsException({
    required super.dioError,
    super.errorCode = '1003',
    super.details,
  });
}

class FailedToConnectToService extends BaseApiException {
  /// failed to connect to open street map service
  FailedToConnectToService({
    required super.dioError,
    super.errorCode = '666',
    super.details,
  });
}

class InvalidIdException extends BaseApiException {
  /// invalid_id
  InvalidIdException({
    required super.dioError,
    super.errorCode = '1170',
    super.details,
  });
}
