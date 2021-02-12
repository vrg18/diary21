/// сущьность Пользователь приложения
class User {
  final String _id;
  final String _email;
  final String _token;

  User(this._id, this._email, this._token);

  get id => _id;

  get email => _email;

  get token => _token;
}
