part of '../repository.dart';

class AuthLocal {
  storeUserData(User user) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setInt('id', user.id);
    await storage.setString('name', user.name);
    await storage.setString('address', user.address);
    await storage.setString('description', user.description);
    await storage.setString('email', user.email);
    await storage.setString('phone', user.phone);
    await storage.setString('profile_photo_url', user.profilePhotoUrl);
  }

  Future<User> getUserData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return User(
      id: storage.getInt('id'),
      name: storage.getString('name'),
      address: storage.getString('address'),
      description: storage.getString('description'),
      email: storage.getString('email'),
      phone: storage.getString('phone'),
      profilePhotoUrl: storage.getString('profile_photo_url'),
    );
  }

  storeToken(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString('token');
  }
}
