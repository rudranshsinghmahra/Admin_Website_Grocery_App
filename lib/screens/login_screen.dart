import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/firebase_services.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();
  final FirebaseServices _services = FirebaseServices();
  String? username;
  String? password;

  Future<void> _login() async {
    _services.getAdminCredentials().then((value) async {
      for (var element in value.docs) {
        if (element.get('username') == username &&
            (element.get('password') == password)) {
          UserCredential userCredentials =
              await FirebaseAuth.instance.signInAnonymously();
          if (userCredentials.user?.uid != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            return;
          } else {
            showAlert("Login Failed");
          }
        }
        return showAlert("Invalid Admin Credentials");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: const Text("Grocery App Admin Dashboard"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _initialize,
        builder: (context, snapshot) {
          // if(snapshot.hasError){
          //   return const Center(
          //     child: Text("Connection Has Error"),
          //   );
          // }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(stops: [
                  1.0,
                  1.0
                ], colors: [
                  Colors.deepPurpleAccent,
                  Colors.white,
                ], begin: Alignment.topCenter, end: Alignment(0.0, 0.0)),
              ),
              child: Center(
                child: Container(
                  child: Card(
                    shape: Border.all(color: Colors.deepPurpleAccent, width: 3),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Image.asset('assets/logo.png'),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "GROCERY ADMIN APP",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Username";
                                      }
                                      setState(() {
                                        username = value.toString();
                                      });
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.person),
                                        hintText: "Username",
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Password";
                                      }
                                      if (value.length < 6) {
                                        return "Enter A Strong Password";
                                      }
                                      setState(() {
                                        password = value.toString();
                                      });
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.vpn_key_sharp),
                                      hintText: "Password",
                                      contentPadding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        _login();
                                      }
                                    },
                                    child: const Text("Login"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  width: 300,
                  height: 400,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
