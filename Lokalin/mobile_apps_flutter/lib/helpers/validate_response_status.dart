part of 'helpers.dart';

void validateResponseStatus(int status, int validStatus, [http.Response response]) {
  if (status == 401) {
    throw new AuthException("401", "Unauthorized");
  }

  if (status != validStatus) {
    if (status == 404) {
      throw new ApiException(status.toString(), 'Not found');
    } else if (status == 422) {
      final _msg = json.decode(response.body);
      throw new ApiException(status.toString(), _msg);
    }
    throw new ApiException(status.toString(), 'Server down');
  }
}

class AuthException implements Exception {
  AuthException(this.code, this.message);

  final String code;
  final String message;
}

class ApiException implements Exception {
  ApiException(this.code, this.message);

  final String code;
  final String message;
}
