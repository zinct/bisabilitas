///
/// failure.dart
/// lib/core/errors/failures
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  // Development Failure
  const factory Failure.developmentFailure({
    required Failure failure,
    required Type runtimeType,
    required String message,
    StackTrace? stackTrace,
  }) = DevelopmentFailure;

  // Api Failure
  const factory Failure.apiFailure({
    int? code,
    String? message,
  }) = ApiFailure;

  // Posible Network Failures
  const factory Failure.requestCancelledFailure() = RequestCancelledFailure;
  const factory Failure.unauthorisedRequestFailure() =
      UnauthorizedRequestFailure;
  const factory Failure.badRequestFailure() = BadRequestFailure;
  const factory Failure.notFoundFailure() = NotFoundFailure;
  const factory Failure.methodNotAllowedFailure() = MethodNotAllowedFailure;
  const factory Failure.notAcceptableFailure() = NotAcceptableFailure;
  const factory Failure.requestTimeoutFailure() = RequestTimeoutFailure;
  const factory Failure.sendTimeoutFailure() = SendTimeoutFailure;
  const factory Failure.conflictFailure() = ConflictFailure;
  const factory Failure.internalServerErrorFailure() =
      InternalServerErrorFailure;
  const factory Failure.notImplementedFailure() = NotImplementedFailure;
  const factory Failure.serviceUnavailableFailure() = ServiceUnavailableFailure;
  const factory Failure.noInternetConnectionFailure() =
      NoInternetConnectionFailure;
  const factory Failure.formatFailure() = FormatFailure;
  const factory Failure.unableToProcessFailure() = UnableToProcessFailure;
  const factory Failure.otherErrorFailure() = OtherErrorFailure;
  const factory Failure.unexpectedFailure() = UnexpectedFailure;
  const factory Failure.forbiddenErrorFailure() = ForbiddenErrorFailure;
  const factory Failure.badCertificateFailure() = BadCertificateFailure;
  const factory Failure.tooManyAttemptRequestFailure() =
      TooManyAttemptRequestFailure;

  // Custom Failure
  const factory Failure.dataNotFoundFailure() = DataNotFoundFailure;
  const factory Failure.unableToOpenGoogleMaps() =
      UnableToOpenGoogleMapsFailure;
  const factory Failure.invalidGiveDataFailure(String? message, dynamic data) =
      InvalidGivenDataFailure;
  const factory Failure.voucherInvalidFailure(String message) =
      VoucherInvalidFailure;

  // Location Failure
  const factory Failure.locationPermissionDeniedFailure() =
      LocationPermissionDeniedFailure;
  const factory Failure.locationPermissionDeniedPermanentFailure() =
      LocationPermissionDeniedPermanentFailure;
  const factory Failure.locationDisabledFailure() =
      LocationPermissionDisabledFailure;
}
