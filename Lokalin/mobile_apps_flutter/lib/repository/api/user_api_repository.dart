part of '../repository.dart';

class UserRepository {
  final Api api = Api();

  // Update Profile
  Future<ApiCek<User>> updateProfile(
    String name,
    String phone,
    String address,
    String description,
    String fcmToken,
  ) async {
    final url = api.user;

    Map<String, String> body = {
      'name': '$name',
      'phone': '$phone',
      'address': '$address',
      'description': '$description',
      'fcmToken': '$fcmToken',
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
        User data = User.fromJson(responseBody['data']);

        return ApiCek<User>(data: data, isSucces: true);
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
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

  // Update Photo Profile
  Future<ApiCek<User>> updatePhotoProfile(
    File file,
  ) async {
    final url = api.uploadUserPhoto;

    var request = http.MultipartRequest("POST", Uri.parse(url));

    var pic = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(pic);

    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      final responseBody = json.decode(responseString);
      // print(responseString);
      if (response.statusCode == 200) {
        return ApiCek<User>(
          isSucces: true,
        );
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
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
}
