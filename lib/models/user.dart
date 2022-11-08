class User {
  var uid;
  var _name;
  var _email;
  var _password;
  var _genre;
  var _bornDate;

  User(this._name, this._email, this._password, this._genre, this._bornDate,);

  User.empty();

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _genre = json['genre'];
    _bornDate = json['bornDate'];
  }

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'name' : _name,
    'email' : _email,
    'password' : _password,
    'genre' : _genre,
    'bornDate' : _bornDate,
  };

  String get email => _email;

  String get password => _password;
}