import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'LoginBloc.dart';
import 'CourseList.dart';
import 'package:email_validator/email_validator.dart';
//import 'package:appflutter/UI/auth/RoundButton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //   automaticallyImplyLeading: false,
      // ),
      // body: Column(
      // children: [
      child: SingleChildScrollView(
          child: Column(children: [
        Form(
            key: _formKey,
            child: Column(children: [
              //Theme( co),
              // const SizedBox(
              //   height: 30.0,
              // ),
              // Image.asset(
              //   "assets/welcome.png",
              //   fit: BoxFit.cover,
              //   width: 200.0,
              // ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 32.0),
                  child: Column(children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      maxLength: (50),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Email Address';
                        }
                        final bool isValid = EmailValidator.validate(value);
                        if (!isValid) {
                          return 'Enter a valid email address ';
                        }
                        return null;
                      },
                      // validator: ((value) {
                      //   if (value.isNull){
                      //     return null;
                      //   }
                      // } ,
                      decoration: const InputDecoration(
                          hintText: " abc@gmail.com",
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 60, 5, 69),
                              fontWeight: FontWeight.bold))
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      maxLength: (20),
                      decoration: const InputDecoration(
                          hintText: " Enter Password",
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 60, 5, 69),
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text("Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 60, 5, 69),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            // Sign in with email and password
                            UserCredential userCredential =
                                await _auth.signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                            );

                            // Navigate to the success page if login is successful
                            if (userCredential.user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseList()),
                              );
                            }
                          } catch (e) {
                            // Handle any errors that occur during login
                            print(e);
                          }
                        }
                      },

                      // ElevatedButton(
                      //   onPressed: () {
                      //     MaterialPageRoute(builder: (context) => SucessFull());
                      //     // Navigator.pushNamed(context, MyRoutes.SubjectSelectionScreen);
                      //   },
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: Size(350, 50),
                          backgroundColor: Color.fromARGB(255, 60, 5, 69)),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(children: [
                      Expanded(
                          child: Divider(
                              thickness: 1.0,
                              color: Color.fromARGB(255, 60, 5, 69))),
                      Text(" OR CONNECT WITH ",
                          style:
                              TextStyle(color: Color.fromARGB(255, 60, 5, 69))),
                      Expanded(
                          child: Divider(
                              thickness: 1.0,
                              color: Color.fromARGB(255, 60, 5, 69)))
                    ]),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(
                        onTap: () {
                          // Add Google sign-in functionality here
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                width: 2,
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // FaIcon(
                                  //   FontAwesomeIcons.google,
                                  //   color: Colors.white,
                                  // ),
                                  Text(
                                    "  Google",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 150,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              border: Border.all(
                                width: 2,
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //icon: FaIcon(FontAwesomeIcons.gamepad)
                                  //Icon(FaIcon(FontAwes)),
                                  // FaIcon(
                                  //   FontAwesomeIcons.facebook,
                                  //   color: Colors.white,
                                  // ),

                                  Text(
                                    "  Facebook",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                      ),
                    ]),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("SignUp"),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: Size(350, 50),
                          backgroundColor: Color.fromARGB(255, 60, 5, 69)),
                    ),
                  ]))
            ]))
      ])),
    );
  }
}
