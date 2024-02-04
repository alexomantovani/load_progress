// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_progress/views/home/bloc/get_workouts_bloc.dart';
import 'package:load_progress/views/workout/workout_form.dart';
import 'package:load_progress/views/workout/workout_page.dart';

import '../../models/user/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.user});

  final User? user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    getWorkouts();
  }

  getWorkouts() async {
    if (widget.user != null) {
      BlocProvider.of<GetWorkoutsBloc>(context)
          .add(ListWorkoutsEvent(widget.user!.usuarioId));
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
        child: BlocBuilder<GetWorkoutsBloc, GetWorkoutsState>(
          builder: (context, state) {
            if (state is GetWorkoutsLoadedState) {
              return ListView.builder(
                itemCount: state.workouts.length,
                itemBuilder: (context, index) => state.workouts.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum treino cadastrado',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WorkoutPage(
                              treonoId: state.workouts[index]!.treinoId,
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.blue,
                          ),
                          height: 200.0,
                          margin: const EdgeInsets.all(12.0),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.workouts[0]!.tipoTreino,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    state.workouts[0]!.exercicios[0]
                                        .grupoMuscularAlvo,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              );
            } else if (state is GetWorkoutsLoadingState) {
              return const CircularProgressIndicator();
            } else {
              return Column(
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
                        builder: (context) => WorkoutForm(
                            email:
                                widget.user != null ? widget.user!.email : ''),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: 140.0,
                      padding: const EdgeInsets.all(8.0),
                      child: state is GetWorkoutsInitialState
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
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
              );
            }
          },
        ),
      ),
      floatingActionButton: BlocBuilder<GetWorkoutsBloc, GetWorkoutsState>(
        builder: (context, state) {
          if (state is GetWorkoutsLoadedState) {
            return FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkoutForm(email: widget.user!.email),
                  ),
                );
              },
              label: const Text('Adicionar treino'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.white,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
