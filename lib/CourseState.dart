import 'package:flutter_bloc/flutter_bloc.dart';
import 'Course.dart';

class CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadedState extends CourseState {
  final List<Course> courses;

  CourseLoadedState({required this.courses});
}

class CourseErrorState extends CourseState {
  final String error;

  CourseErrorState({required this.error});
}
