class User {
  var uid;
  var _name;
  var _email;
  var _password;
  var _gender;
  var _bornDate;

  User(this._name, this._email, this._password, this._gender, this._bornDate,);

  User.empty();

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _gender = json['gender'];
    _bornDate = json['bornDate'];
  }

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'name' : _name,
    'email' : _email,
    'password' : _password,
    'gender' : _gender,
    'bornDate' : _bornDate,
  };

  String get email => _email;

  String get password => _password;
}
