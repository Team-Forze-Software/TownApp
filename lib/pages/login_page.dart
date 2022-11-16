import 'package:flutter/material.dart';
import 'package:town_app/pages/poi_list.dart';
import 'package:town_app/pages/register_page.dart';
import 'package:town_app/repositories/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  void _showMsg(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: "Aceptar",
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  void _validateUser() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMsg("Digite un usuario y una contraseña");
    } else {
      var result = await _userRepository.loginUser(_email.text, _password.text);
      String msg = "";
      if (result == "invalid-email") {msg = "Correo incorrecto";}
      else if (result == "wrong-password") {msg = "Contraseña incorrecta";}
      else if (result == "user-not-found") {msg = "No existe un usario con estos datos";}
      else if (result == "network-request-failed") {msg = "Revise su conexión de red";}
      else {
        msg = "Bienvenido";
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const POIList()));
        });
      }
      _showMsg(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/fondo1.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4), BlendMode.colorBurn),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(image: AssetImage("assets/images/logo.png")),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo electrónico",
                      icon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Contraseña",
                        icon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _validateUser();
                      },
                      child: const Text("Iniciar sesión"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text("Registrese"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
