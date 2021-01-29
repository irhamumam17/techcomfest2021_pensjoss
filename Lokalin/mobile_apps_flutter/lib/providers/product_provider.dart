part of 'providers.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository productRepository = ProductRepository();
  AuthProvider authProvider = AuthProvider();

  List<Product> products;
  List<Product> myProducts;
  Product detailProduct;
  String nextPageGetProducts;

  // Get Products
  Future<ApiCek<List<Product>>> getProducts() async {
    try {
      ApiCek<List<Product>> result = await productRepository.getProducts();

      if (result.data != null) {
        // Store data
        products = result.data;
        nextPageGetProducts = result.nextPageUrl;
        notifyListeners();
      } else {
        notifyListeners();
      }
      return result;
    } on AuthException catch (e) {
      await authProvider.logout(true);
      return ApiCek(isSucces: false, message: e.message);
    } catch (e) {
      return ApiCek(
          isSucces: false, message: 'Internet tidak dapat terhubung ke server');
    }
  }

  // Get Products
  Future<ApiCek<List<Product>>> getMyProduct([int userId]) async {
    try {
      ApiCek<List<Product>> result =
          await productRepository.getProducts(userId);

      if (result.data != null) {
        // Store data
        myProducts = result.data;
        nextPageGetProducts = result.nextPageUrl;
        notifyListeners();
      } else {
        notifyListeners();
      }
      return result;
    } on AuthException catch (e) {
      await authProvider.logout(true);
      return ApiCek(isSucces: false, message: e.message);
    } catch (e) {
      return ApiCek(
          isSucces: false, message: 'Internet tidak dapat terhubung ke server');
    }
  }

  // Detail Product

  Future<ApiCek<Product>> getDetailProducts(int id) async {
    try {
      ApiCek<Product> result = await productRepository.getDetailProducts(id);

      if (result.data != null) {
        // Store data
        detailProduct = result.data;
        notifyListeners();
      } else {
        notifyListeners();
      }
      return result;
    } on AuthException catch (e) {
      await authProvider.logout(true);
      return ApiCek(isSucces: false, message: e.message);
    } catch (e) {
      return ApiCek(
          isSucces: false, message: 'Internet tidak dapat terhubung ke server');
    }
  }

  // Create Products
  Future<ApiCek<Product>> createProduct(
    String name,
    String description,
    String category,
    String targetFunding,
    String targetEnd,
    String videoPath,
    File file,
  ) async {
    try {
      ApiCek<Product> result = await productRepository.createProduct(
        name,
        description,
        category,
        targetFunding,
        targetEnd,
        videoPath,
        file,
      );

      return result;
    } on AuthException catch (e) {
      await authProvider.logout(true);
      return ApiCek(isSucces: false, message: e.message);
    } catch (e) {
      return ApiCek(
          isSucces: false, message: 'Internet tidak dapat terhubung ke server');
    }
  }
}
