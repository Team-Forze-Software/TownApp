
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:town_app/pages/login_page.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
enum Genre { masculino, femenino}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  bool _isObscure = true;
  bool _isObscure1 = true;

  Genre? _genre = Genre.masculino;
  String buttonMsg ="Fecha de nacimiento";

  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  void _showSelectDate()async{
      DateTime? pickedDate = await showDatePicker(
          context: context, initialDate: DateTime.now(),
          locale: const Locale("es","CO"),
          firstDate: DateTime(1920), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101)
      );

      if(pickedDate != null ){
        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        print(formattedDate); //formatted date output using intl package =>  2021-03-16
        //you can implement different kind of Date Format here according to your requirement

        setState(() {
          dateinput.text = formattedDate; //set output date to TextField value.
        });
      }else{
        print("Date is not selected");
      }
  }

  void _showMsg(String msg){
    final scaffold = ScaffoldMessenger.of(context) ;
    scaffold.showSnackBar(
      SnackBar(content: Text(msg),
        action: SnackBarAction(
            label: "Aceptar", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  void saveUser(User user)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }

  void _onRegisterButtonClicked(){
    setState(() {
      if(_password.text==_repPassword.text) {
        String genre = "Masculino";

        if (_genre == Genre.femenino) {
          genre = "Femenenino";
        }

        var user = User(_name.text, _email.text, _password.text, genre, dateinput.text);
        saveUser(user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> LoginPage()));
      }else{
        _showMsg("Las Contraseñas deben de ser iguales");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage("assets/images/fondo1.jpg"),
            fit: BoxFit.cover,
            colorFilter:ColorFilter.mode(Colors.white.withOpacity(0.4),BlendMode.colorBurn),
          ) ,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical:20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  const Image(image: AssetImage("assets/images/logo.png"),),
                  SizedBox(height: 15.0,),
                  TextFormField(
                    controller: _name,

                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nombre", icon: Icon(Icons.account_circle_rounded),),

                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Correo electronico",icon: Icon(Icons.email),),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    obscureText: _isObscure1,
                    controller: _password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Contraseña",icon: Icon(Icons.password),
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure1 ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            })
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: _repPassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Repita la contraseña",icon: Icon(Icons.password),
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.0,),

                  TextFormField(

                    controller: dateinput,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), icon: Icon(Icons.cake_rounded), labelText: "Fecha de Nacimiento"),
                    readOnly: true,
                    onTap: (){
                      _showSelectDate();
                    },
                    keyboardType: TextInputType.text,
                  ),
                   SizedBox(height: 20,),
                   Text("Genero:",
                    style: GoogleFonts.damion(textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue,),
                  ),
                  Row(

                     children: [

                      Expanded(
                        child: ListTile(
                          title: const Text("Masculino"),
                          leading: Radio<Genre>(
                              value: Genre.masculino,
                              groupValue: _genre,
                              onChanged: (Genre? value){
                                setState(() {
                                  _genre = value;
                                });
                              }
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("Femenino"),
                          leading: Radio<Genre>(
                              value: Genre.femenino,
                              groupValue: _genre,
                              onChanged: (Genre? value){
                                setState(() {
                                  _genre = value;
                                });
                              }
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      style:TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16 ),
                      ),
                      onPressed: (){
                        _onRegisterButtonClicked();
                      },
                      child: const Text("Registrar")
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
