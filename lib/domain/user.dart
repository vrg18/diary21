class User {
  final String _email;
  final String _id;
  final String _token;

  User(this._email, this._id, this._token);

  String get email => _email;

  String get id => _id;

  String get token => _token;
}
