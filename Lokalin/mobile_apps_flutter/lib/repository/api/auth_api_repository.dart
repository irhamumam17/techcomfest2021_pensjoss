part of '../repository.dart';

class AuthRepository {
  final Api api = Api();

  // Signin
  Future<ApiCek<User>> signin(String email, String password) async {
    final url = api.login;

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    Map<String, String> headers = {'Accept': 'application/json'};

    try {
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        User data = User.fromJson(responseBody['data']['user']);
        String _token = responseBody['data']['access_token'];

        return ApiCek<User>(data: data, token: _token, isSucces: true);
      } else {
        return ApiCek<User>(
            isSucces: false, message: responseBody['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<User>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }

  // Register
  Future<ApiCek<User>> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String phone,
    String address,
  ) async {
    final url = api.register;

    Map<String, String> body = {
      'name': '$name',
      'email': '$email',
      'password': '$password',
      'password_confirmation': '$passwordConfirmation',
      'phone': '$phone',
      'address': '$address',
    };

    Map<String, String> headers = {'Accept': 'application/json'};

    try {
      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        User data = User.fromJson(responseBody['data']['user']);
        String _token = responseBody['data']['access_token'];

        return ApiCek<User>(data: data, token: _token, isSucces: true);
      } else if (response.statusCode == 422) {
        return ApiCek<User>(
            isSucces: false,
            message:
                '${responseBody['errors']['email']} ${responseBody['errors']['password']}');
      } else {
        final _msg = json.decode(response.body);
        return ApiCek<User>(isSucces: false, message: _msg['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<User>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }

  // Logout
  Future<ApiCek<User>> logout() async {
    final url = api.logout;

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
      );
      // print(response.body);
      if (response.statusCode == 200) {
        return ApiCek<User>(isSucces: true);
      } else {
        final _msg = json.decode(response.body);
        return ApiCek<User>(isSucces: false, message: _msg['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<User>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }
}
