part of '../repository.dart';

class ProductRepository {
  final Api api = Api();

  // Get Product
  Future<ApiCek<List<Product>>> getProducts([int userId]) async {
    String url = api.product;

    if (userId != null) {
      url = url + '?user_id=$userId';
    }

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
        List<Product> data = List<Product>.from(
            responseBody["data"]['data'].map((x) => Product.fromJson(x)));

        return ApiCek<List<Product>>(
          data: data,
          nextPageUrl: responseBody['data']['next_page_url'],
          isSucces: true,
        );
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
      } else {
        return ApiCek<List<Product>>(
            isSucces: false, message: responseBody['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<List<Product>>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }

   // Get Detail Product
  Future<ApiCek<Product>> getDetailProducts(int id) async {
    String url = api.product+'?id=$id';

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
        Product data = Product.fromJson(responseBody["data"]);

        return ApiCek<Product>(
          data: data,
          isSucces: true,
        );
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
      } else {
        return ApiCek<Product>(
            isSucces: false, message: responseBody['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<Product>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }

  // Post Product
  Future<ApiCek<Product>> createProduct(
    String name,
    String description,
    String category,
    String targetFunding,
    String targetEnd,
    String videoPath,
    File file,
  ) async {
    final url = api.product;

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['category'] = category;
    request.fields['target_funding'] = targetFunding;
    request.fields['target_end'] = targetEnd;
    request.fields['video_path'] = videoPath;

    if (file != null) {
      var pic = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(pic);
    } else {}

    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      final responseBody = json.decode(responseString);
      // print(responseString);
      if (response.statusCode == 200) {
        Product data = Product.fromJson(responseBody['data']['product']);
        return ApiCek<Product>(
          data: data,
          isSucces: true,
        );
      } else if (response.statusCode == 401) {
        throw new AuthException("401", "Unauthorized");
      } else {
        return ApiCek<Product>(
            isSucces: false, message: responseBody['meta']['message']);
      }
    } catch (e) {
      print(e);
      return ApiCek<Product>(
          isSucces: false, message: "Internet tidak dapat terhubung keserver");
    }
  }
}
