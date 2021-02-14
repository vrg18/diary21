import 'package:diary/data/storage/user_storage.dart';
import 'package:diary/domain/user.dart';

/// Бизнес-логика сущьности Пользователь
/// Используется Provider
class CurrentUser {
  late UserStorage _userStorage = UserStorage();
  late User _user;

  get user => _user;

  Future<String> login(String email, String password) async {
    dynamic returned = await _userStorage.login(email, password);
    if (returned is User) {
      _user = returned;
      returned = '';
    }
    return returned;
  }

  Future<String> googleLogin() async {
    dynamic returned = await _userStorage.googleLogin();
    if (returned is User) {
      _user = returned;
      returned = '';
    }
    return returned;
  }

  Future<String> createLogin(String email, String password) => _userStorage.createLogin(email, password);

  Future<String> forgotLogin(String email) => _userStorage.forgotLogin(email);
}
