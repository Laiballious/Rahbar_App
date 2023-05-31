import 'package:flutter/material.dart';
import 'Course.dart';
class TopicListPage extends StatelessWidget {
  final Course course;

  TopicListPage({required this.course});

  @override
  Widget build(BuildContext context) {
    // Implement your TopicListPage UI here
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Center(
        child: Text('Topic List Page for ${course.title}'),
      ),
    );
  }
}
