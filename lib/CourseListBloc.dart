import 'package:flutter_bloc/flutter_bloc.dart';
import 'Course.dart';
import 'CourseState.dart';

abstract class CourseEvent {}

class FetchCoursesEvent extends CourseEvent {}

class CourseListBloc extends Bloc<CourseEvent, CourseState> {
  CourseListBloc() : super(CourseLoadingState()) {
    on<FetchCoursesEvent>(_fetchCourses);
  }

  void _fetchCourses(FetchCoursesEvent event, Emitter<CourseState> emit) async {
    emit(CourseLoadingState());

    try {
      await Future.delayed(Duration(seconds: 2));
      final courses = [
        Course(
          title: 'Maths',
          image: 'assets/images/Maths.png',
          description:
              'Get ready to ace your math exams with our comprehensive course content, covering Algebra Geometry, Trigonometry, Calculus, and more to entice users to select the Maths course',
          progress: 0,
        ),
        Course(
          title: 'English',
          image: 'assets/images/Maths.png ',
          description:
              'Learn English grammar, vocabulary, and conversation skills with our comprehensive English course. Our course is designed to help you become fluent in English and achieve your language goals ',
          progress: 0,
        ),
        Course(
          title: 'Mock Test',
          image: 'assets/images/PracticePaper.png',
          description:
              'Prepare for success with our mock tests - designed to simulate actual exam conditions, and help you practice Take advantage of our comprehensive mock tests, and increase your chances of acing your exams.',
          progress: 0,
        ),
      ];

      emit(CourseLoadedState(courses: courses));
    } catch (error) {
      // Handle error if any
      emit(CourseErrorState(error: error.toString()));
    }
  }

  @override
  CourseState get initialState => CourseLoadingState();
}
