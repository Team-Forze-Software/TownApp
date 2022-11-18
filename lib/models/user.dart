import 'package:town_app/pages/register_page.dart';

class User {
  String uid = "";
  String _name = "Name";
  String _email = "example@example.com";
  String _password = "password";
  String _gender = Gender.masculino.name;
  String _bornDate = "2000-01-01";
  List<String> _favorites = [];

  User(this.uid, this._name, this._email, this._password, this._gender, this._bornDate, this._favorites,);

  User.empty();

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _gender = json['gender'];
    _bornDate = json['bornDate'];
    _favorites = json["favorites"];
  }

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'name' : _name,
    'email' : _email,
    'password' : _password,
    'gender' : _gender,
    'bornDate' : _bornDate,
    'favorites' : _favorites,
  };

  String get email => _email;

  String get password => _password;
}
