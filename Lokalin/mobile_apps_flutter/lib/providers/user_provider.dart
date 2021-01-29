part of 'providers.dart';

class UserProvider extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  final UserRepository userRepository = UserRepository();
  final AuthLocal authLocal = AuthLocal();

  User myUser;
  // Signin
  Future<ApiCek<User>> updateProfile({
    String name,
    String phone,
    String address,
    String description,
    String fcmToken,
  }) async {
    try {
      ApiCek<User> result = await userRepository.updateProfile(
        name,
        phone,
        address,
        description,
        fcmToken,
      );

      if (result.data != null) {
        // Store data
        myUser = result.data;
        // Store local data
        await authLocal.storeUserData(result.data);
        notifyListeners();
      }
      return result;
    } on AuthException catch (e) {
      await authProvider.logout(true);
      return ApiCek<User>(isSucces: false, message: e.message);
    } catch (e) {
      return ApiCek<User>(
          isSucces: false, message: 'Internet tidak dapat terhubung ke server');
    }
  }

  Future<ApiCek<User>> updatePhotoProfile({File file}) async {
    try {
      ApiCek<User> result = await userRepository.updatePhotoProfile(file);

      return result;
    } on AuthException catch (e) {
      await authProvider.logout(true);
      return ApiCek<User>(isSucces: false, message: e.message);
    } catch (e) {
      return ApiCek<User>(
          isSucces: false, message: 'Internet tidak dapat terhubung ke server');
    }
  }
}
