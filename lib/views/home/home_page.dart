// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:load_progress/services/workout/workout_service.dart';
import 'package:load_progress/views/workout/workout_form.dart';

import '../../models/user/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.user});

  final User? user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  @override
  void initState() {
    getWorkouts();
    super.initState();
  }

  getWorkouts() async {
    if (widget.user != null) {
      final response =
          await WorkoutService().listWorkouts(widget.user!.usuarioId);
      if (response != null && response.isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WorkoutForm(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 8.0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.menu, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(flex: 3),
            const Text(
              'Nenhum treino cadastrado',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WorkoutForm(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: 140.0,
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : const Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
