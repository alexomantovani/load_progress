import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_progress/views/home/bloc/get_workouts_bloc.dart';
import 'package:load_progress/views/signup/bloc/getUser/get_user_bloc.dart';
import 'package:load_progress/views/signup/bloc/signup/sign_up_bloc.dart';
import 'package:load_progress/views/signup/sign_up_page.dart';
import 'package:load_progress/views/workout/bloc/workout_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetUserBloc>(
          create: (context) => GetUserBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<WorkoutBloc>(
          create: (context) => WorkoutBloc(),
        ),
        BlocProvider<GetWorkoutsBloc>(
          create: (context) => GetWorkoutsBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUpPage(),
      ),
    );
  }
}
