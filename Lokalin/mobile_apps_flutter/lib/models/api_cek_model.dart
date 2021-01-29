part of 'models.dart';

class ApiCek<T> {
  final String message;
  final String status;
  final bool isSucces;
  final T data;
  final String nextPageUrl;
  final String token;

  ApiCek({
    this.message,
    this.status,
    this.isSucces,
    this.data,
    this.nextPageUrl,
    this.token,
  });
}
