import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CourseList.dart';
import 'SignUp.dart';
import 'Login.dart';
import 'Course.dart';
import 'TopicListPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.amber[900],
      title: "Firebase",
      // theme: ThemeData(primarySwatch: Colors.amber),
      initialRoute: '/',
      routes: {
        '/': (context) => SignUp(),
        '/courseList': (context) => CourseList(),
        // '/topicList': (context) => TopicListPage(
        //     course: Course(
        //         title: 'Maths',
        //         image: 'assets/images/Maths.png',
        //         description: 'Sample description',
        //         progress: 0)),

        // '/topicList': (context) => TopicListPage(),
      },
    );
  }
}
