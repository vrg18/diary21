import 'package:diary/data/res/properties.dart';
import 'package:diary/domain/user.dart';
import 'package:diary/ui/res/strings.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserStorage {
  final Dio _dioAuth = Dio(BaseOptions(baseUrl: urlAuth));
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      goodleAuthApi,
    ],
  );

  dynamic login(String email, String password) async {
    try {
      var response = await _dioAuth.post(
        signIn,
        data: {
          'email': email,
          'password': password,
        },
      );
      return _authContinueOk(response, true);
    } catch (e) {
      return _authContinueException(e);
    }
  }

  dynamic googleLogin() async {
    try {
      GoogleSignInAccount user = (await _googleSignIn.signIn())!;
      GoogleSignInAuthentication googleSignInAuthentication = await user.authentication;
//      print(googleSignInAuthentication.accessToken);
      var response = await _dioAuth.post(
        googleIn,
        data: {
          'state': googleState,
          'token': googleSignInAuthentication.accessToken,
        },
      );
      return _authContinueOk(response, true);
    } catch (e) {
      return _authContinueException(e);
    }
  }

  Future<String> createLogin(String email, String password) async {
    try {
      var response = await _dioAuth.post(
        signUp,
        data: {
          'email': email,
          'password': password,
        },
      );
      String error = _authContinueOk(response, false);
      if (error.isNotEmpty) return error;
      return mailCheckRequest;
    } catch (e) {
      return _authContinueException(e);
    }
  }

  Future<String> forgotLogin(String email) async {
    try {
      var response = await _dioAuth.post(
        passReset,
        data: {
          'email': email,
        },
      );
      String error = _authContinueOk(response, false);
      if (error.isNotEmpty) return error;
      return passwordResetRequest;
    } catch (e) {
      return _authContinueException(e);
    }
  }

  dynamic _authContinueOk(response, isLogin) {
//    print('Ответ: ${response.statusCode}/${response.statusMessage}, Содержимое: ${response.data}');
    if (response.statusCode < 300) {
      if (isLogin) {
        return User(
          response.data['user']['id'],
          response.data['user']['email'],
          response.data['token'],
        );
      } else {
        return '';
      }
    } else {
      return response.statusMessage;
    }
  }

  String _authContinueException(error) {
    if (error is DioError) {
      if (error.response!.data.containsKey('message')) {
        return error.response!.data['message'];
      } else {
        return error.response!.data;
      }
    } else {
      return error.toString();
    }
  }
}
