part of '../repository.dart';

class TransactionRepository {
  final Api api = Api();

  // Get Transaction
  Future<ApiCek<List<Transaction>>> getTransaction() async {
    final url = api.transaction;

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        List<Transaction> data = List<Transaction>.from(
            responseBody["data"]['data'].map((x) => Transaction.fromJson(x)));

        return ApiCek<List<Transaction>>(
          data: data,
          nextPageUrl: responseBody['data']['next_page_url'],
          isSucces: true,
        );
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
      } else {
        return ApiCek<List<Transaction>>(
            isSucces: false, message: responseBody['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<List<Transaction>>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }

  // Register
  Future<ApiCek<Transaction>> checkout(
    int productId,
    int userId,
    int total,
    String status,
    String message,
  ) async {
    final url = api.checkout;

    Map<String, String> body = {
      'product_id': '$productId',
      'user_id': '$userId',
      'total': '$total',
      'status': 'PENDING',
      'message': message,
    };

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      
      final responseBody = json.decode(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        Transaction data = Transaction.fromJson(responseBody['data']);

        return ApiCek<Transaction>(data: data, isSucces: true);
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
      } else {
        final _msg = json.decode(response.body);
        return ApiCek<Transaction>(
            isSucces: false, message: _msg['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<Transaction>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }
}
