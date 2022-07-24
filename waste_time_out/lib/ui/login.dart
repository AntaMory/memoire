import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:waste_time_out/model/jwt-token.dart';
import 'package:waste_time_out/model/user.dart';
import 'package:waste_time_out/sqlite/connexionDB.dart';


class LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        brightness: Brightness.light,
        backgroundColor: Colors.white,

      ),
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _postJson;
  var _obscureText = true;
  List<User> userss = [];
  bool responseApi = false;

  late String _username;
  late String _password;
  late Map<String, dynamic> tokenJson;
  late JWTToken jwtToken;
  final _formKey = GlobalKey<FormState>();
  bool responseUser = false;
  final storage = new FlutterSecureStorage();

  //final storage = new FlutterSecureStorage();
  late List list;
  bool loading = true;
  bool _etat = false;
  final dbHelper = DatabaseHelper.instance;


  @override
  void initState() {
    super.initState();

  }


  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/timer.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "TIME_OUT",
              style: TextStyle(color: Colors.white54, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                ListTile(
                  title: TextFormField(
                    controller: myControllerUsername,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Entrez votre nom d\'utilisateur';
                      }else {
                        myControllerUsername.text = value;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Nom d\'utilisateur',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    //decoration: InputDecoration(hintText: "Telephone"),

                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: TextFormField(
                    controller: myControllerPassword,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Entrez votre Votre mot de passe';
                      }else {
                        myControllerPassword.text= value;
                        return null;
                      }
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Mot de passe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.black,

                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    // maxLength: 4,
                    //keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: Size(170.0, 90.0),
                          minimumSize: Size(170.0, 60.0),
                          primary: Colors.black,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () async {_username = myControllerUsername.text;
                        _password = myControllerPassword.text;

                        if(_formKey.currentState!.validate()) {
                          final res = await dbHelper.selectOneRow(
                              _username, _password);

                          // print('res'+res);
                          if (res > 0) {
                            print(res);
                            print("connexion avec sqlite");
                           // int et = await dbHelper.updateUserConnecte();
                           // print(et);

                            //  Navigator.pushNamed(context, '/histo');

                          }
                          else {
                            //getAllUsers();
                            // Navigator.pushNamed(context, '/histo');
                          }
                        }
                        },
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Se connecter'),
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(

                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text(
                          'S\'inscrire',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Mot de passe oublié',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
 /* Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: setbody(),
      ),
    );
  }





  Form setbody(){
    return Form(
      // body: Column(
      key: _formKey,
      //mainAxisSize: MainAxisSize.max,
      // children: [
      child: Column(
        children: [
          Row(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.fromLTRB(105, 20, 50, 0),
                height: 160,
                width: 160,
               child: new Image.asset('assets/images/timer.jpg'),
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    controller: myControllerUsername,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Entrez votre numéro de telephone';
                      }else {
                        myControllerUsername.text = value;
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: "Telephone"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: TextFormField(
                    controller: myControllerPassword,
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'Entrez votre Pin';
                      }else {
                        myControllerPassword.text= value;
                        return null;
                      }
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "mot de passe",
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.black,

                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    // maxLength: 4,
                    //keyboardType: TextInputType.number,
                  ),
                ),


              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: EdgeInsets.only(top: 3, left: 10),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  _username = myControllerUsername.text;
                  _password = myControllerPassword.text;

                },

                color: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(44)),
                child: Text(
                  "Connexion",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: EdgeInsets.only(top: 3, left: 10),
              child: MaterialButton(
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(44)),
                onPressed: () {
                  Navigator.pushNamed(context, '/inscription');
                },
                //shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(44)
                // ),

                child: Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.purpleAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          // The GestureDetector wraps the button.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              padding: EdgeInsets.only(top: 3, left: 10),
              child: MaterialButton(
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(44)),
                onPressed: () {
                  //Navigator.pushNamed(context, '/changePasswd');
                  Navigator.of(context).pushNamed('/changePasswd');
                },

                //shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(44)
                // ),

                child: Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.purpleAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
      //  ],
      //),

    );
  }
//connnection
 /* getAllUsers() async {
    _username = myControllerUsername.text;
    _password = myControllerPassword.text;
    UserService.autheticate(_username.trim(), _password)
        .then((response) async =>
    {


      if (response.statusCode == HttpStatus.ok)
        {
          // userDetails= await _fetchInfractions(),
          print(' utilisateur  a pour  id '),
          tokenJson = json.decode(response.body),
          jwtToken = JWTToken.fromJson(tokenJson),
          // saving token

          storage.write(key: 'token', value: jwtToken.id_token),
          tokenJson = json.decode(response.body),
          _etat=true,

          await userDetailsService.getLogin(_username).then((response) =>

          {

            if(response.statusCode == HttpStatus.ok){
              print(' utilisateur  a pour  id fetch '),
              print("data body "+ response.statusCode.toString()),


              setState(() {

                _postJson=response.body;

                user = User.fromJson(jsonDecode(_postJson));
                print(user.login.toString());
                print(user.firstName.toString());

                Map<String, dynamic> row = {

                  DatabaseHelper.columnLogin:user.login.toString() ,
                  DatabaseHelper.columnPassword:_password.toString(),
                  DatabaseHelper.columnFirtName: user.firstName.toString(),
                  DatabaseHelper.columnLastName:user.lastName.toString(),
                  DatabaseHelper.columnEmail:user.email.toString(),
                };

                final id =  dbHelper.insertUser(row);
                print(' utilisateur  a pour  id   $id');

                Navigator.pushNamed(context, '/histo');

              }),
            }
            else{
              print('donnée invalide')
            }
          }),


        }
    });
  }*/

  //methode d'insertion


  }


Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
*/

