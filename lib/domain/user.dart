import 'package:diary/domain/properties.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

/// Класс, хранящий текущего пользователя
/// Используется Provider
class User with ChangeNotifier {
  String _email = '';
  late String _id;
  late String _token;

  final Dio _dioAuth = Dio(BaseOptions(baseUrl: urlAuth));

  String get email => _email;

  String get id => _id;

  String get token => _token;

  set email(String value) => _email = value;

  set id(String value) => _id = value;

  set token(String value) => _token = value;

  Future<String> login(String email, String password) async {
    try {
      var response = await _dioAuth.post(
        signIn,
        data: {
          'email': email,
          'password': password,
        },
      );
      print('Ответ: ${response.statusCode}, Содержимое: ${response.data}');
      if (response.statusCode < 300) {
        _email = response.data['user']['email'];
        _id = response.data['user']['id'];
        _token = response.data['token'];
        return '';
      } else {
        print('Сообщение: ${response.statusMessage}');
        return response.statusMessage;
      }
    } catch (e) {
      print('Ошибка: $e');
      if (e is DioError) {
        if (e.response.data.containsKey('message')) {
          return e.response.data['message'];
        } else {
          return e.response.data;
        }
      } else {
        return e.toString();
      }
    }
  }
}
