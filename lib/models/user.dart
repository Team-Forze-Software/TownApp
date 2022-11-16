import 'package:town_app/pages/register_page.dart';

class User {
  String uid = "";
  String _name = "Name";
  String _email = "example@example.com";
  String _password = "password";
  String _gender = Gender.masculino.name;
  String _bornDate = "2000-01-01";

  User(this.uid, this._name, this._email, this._password, this._gender, this._bornDate,);

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
