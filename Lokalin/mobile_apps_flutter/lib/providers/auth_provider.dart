part of 'providers.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();
  final AuthLocal authLocal = AuthLocal();

  Status status = Status.Uninitialized;
  User user;

  // Init
  initAuthProvider() async {
    User _user = await authLocal.getUserData();
    token = await authLocal.getToken();
    if (token != null) {
      user = _user;
      status = Status.Authenticated;
    } else {
      status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  // Signin
  Future<ApiCek<User>> signin(String email, String password) async {
    ApiCek<User> result = await authRepository.signin(email, password);

    if (result.data != null) {
      // Store data
      user = result.data;
      token = result.token;
      status = Status.Authenticated;

      // Store local data
      await authLocal.storeUserData(result.data);
      await authLocal.storeToken(result.token);
      notifyListeners();
    } else {
      status = Status.Unauthenticated;
      notifyListeners();
    }
    return result;
  }

  // Register
  Future<ApiCek<User>> register({
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String phone,
    String address,
  }) async {
    ApiCek<User> result = await authRepository.register(
      name,
      email,
      password,
      passwordConfirmation,
      phone,
      address,
    );

    if (result.data != null) {
      // Store data
      user = result.data;
      token = result.token;
      status = Status.Authenticated;

      // Store local data
      await authLocal.storeUserData(result.data);
      await authLocal.storeToken(result.token);
      notifyListeners();
    } else {
      status = Status.Unauthenticated;
      notifyListeners();
    }
    return result;
  }

  // Logout
  Future<ApiCek<User>> logout([bool tokenExpired = false]) async {
    if (tokenExpired == true) {
      return null;
    } else {
      status = Status.Unauthenticated;
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.clear();
      ApiCek<User> result = await authRepository.logout();
      token = '';
      notifyListeners();
      return result;
    }
  }
}
