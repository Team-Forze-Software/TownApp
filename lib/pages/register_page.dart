import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:town_app/pages/login_page.dart';
import 'package:town_app/repositories/UserRepository.dart';
import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { masculino, femenino }

class _RegisterPageState extends State<RegisterPage> {
  UserRepository userRepository = UserRepository();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  bool _isObscure = true;
  bool _isObscure1 = true;
  Gender? _gender = Gender.masculino;
  String buttonMsg = "Fecha de nacimiento";
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  void _showSelectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        locale: const Locale("es", "CO"),
        firstDate: DateTime(1920),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        dateinput.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  void _showMsg(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: "Aceptar", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text) {
        String gender = _gender == Gender.masculino ? "Masculino" : "Femenino";
        var user = User(
            _name.text, _email.text, _password.text, gender, dateinput.text);
        _registerUser(user);
      } else {
        _showMsg("Las contraseñas deben ser iguales");
      }
    });
  }

  void _registerUser(User user) async {
    var result = await userRepository.registerUser(user.email, user.password);
    String msg = "";
    if (result == "invalid-email") {msg = "El correo electrónico está mal escrito";}
    else if (result == "weak-password") {msg = "La contraseña es débil";}
    else if (result == "email-already-in-use") {msg = "Ya existe una cuenta con ese correo";}
    else if (result == "network-request-failed") {msg = "Revise la conexión de red";}
    else {
      msg = "Usuario registrado exitosamente";
      user.uid = result;
      saveUser(user);
    }
    _showMsg(msg);
  }

  void saveUser(User user) async {
    userRepository.createUser(user);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage("assets/images/logo.png"),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre",
                      icon: Icon(Icons.account_circle_rounded),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo electronico",
                      icon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: _isObscure1,
                    controller: _password,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Contraseña",
                        icon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            })),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: _repPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Repita la contraseña",
                      icon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: dateinput,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.cake_rounded),
                      labelText: "Fecha de Nacimiento",
                    ),
                    readOnly: true,
                    onTap: () {
                      _showSelectDate();
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Genero:",
                    style: GoogleFonts.damion(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text("Masculino"),
                          leading: Radio<Gender>(
                            value: Gender.masculino,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("Femenino"),
                          leading: Radio<Gender>(
                            value: Gender.femenino,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      _onRegisterButtonClicked();
                    },
                    child: const Text("Registrar"),
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
