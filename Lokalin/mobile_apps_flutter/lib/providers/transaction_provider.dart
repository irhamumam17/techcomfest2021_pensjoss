part of 'providers.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository transactionRepository = TransactionRepository();
  AuthProvider authProvider = AuthProvider();

  List<Transaction> transactions;
  String nextPageGetTransaction;

  // Get Products
  Future<ApiCek<List<Transaction>>> getTransaction() async {
    try {
      ApiCek<List<Transaction>> result =
          await transactionRepository.getTransaction();

      if (result.data != null) {
        // Store data
        transactions = result.data;
        nextPageGetTransaction = result.nextPageUrl;
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

  // Checkout
  Future<ApiCek<Transaction>> checkout(
    int productId,
    int userId,
    int total,
    String status,
    String message,
  ) async {
    try {
      ApiCek<Transaction> result = await transactionRepository.checkout(
        productId,
        userId,
        total,
        status,
        message,
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
