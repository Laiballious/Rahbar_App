import 'CourseList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './SignUpBloc.dart';
import './SignUpEvent.dart';
import './SignupState.dart';
import 'Login.dart';
import 'CourseList.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  //late FirebaseFirestore _firestore;

  @override
  //  void initState() {
  //   super.initState();
  //   _firestore = FirebaseFirestore.instance;
  // }
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sign Up'),
          ),
          body:
              BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
            if (state is SignUpSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseList()),
              );
            } else if (state is SignUpFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Sign Up Error'),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          }, builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        // Image.asset(
                        //   "assets/SignUp.jpg",
                        //   fit: BoxFit.cover,
                        //   width: 300.0,
                        // ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 32.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  maxLength: (20),
                                  decoration: const InputDecoration(
                                      hintText: " name ",
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 3, 64, 77),
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  maxLength: (50),
                                  decoration: const InputDecoration(
                                      hintText: " abc@gmail.com",
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 3, 64, 77),
                                          fontWeight: FontWeight.bold)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
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
                                          color: Color.fromARGB(255, 3, 64, 77),
                                          fontWeight: FontWeight.bold)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      try {
                                        UserCredential userCredential =
                                            await _auth
                                                .createUserWithEmailAndPassword(
                                          email:
                                              emailController.text.toString(),
                                          password: passwordController.text
                                              .toString(),
                                        );
                                        User? user = userCredential.user;
                                        if (user != null) {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .set({
                                            'name': nameController.text,
                                            'email': emailController.text,
                                            'password': passwordController.text,
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                   CourseList()),
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: Text("SignUp"),
                                  style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    minimumSize: Size(350, 50),
                                    backgroundColor:
                                        Color.fromARGB(255, 3, 64, 77),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Already have an account?"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()),
                                          );
                                        },
                                        child: const Text(
                                          "Sign In",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 3, 64, 77),
                                          ),
                                        ),
                                      ),
                                    ])
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
    ;
  }
}

