import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_progress/views/workout/bloc/workout_bloc.dart';

class WorkoutForm extends StatefulWidget {
  final String email;

  const WorkoutForm({super.key, required this.email});

  @override
  State<WorkoutForm> createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final TextEditingController _workoutTypeController = TextEditingController();
  final TextEditingController _workoutNameController = TextEditingController();
  final TextEditingController _workoutMuscleGroupController =
      TextEditingController();
  final TextEditingController _workoutRepsController = TextEditingController();

  bool isLoading = false;
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutCreatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(state.response['success']),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _workoutTypeController,
                    decoration: InputDecoration(
                      helperText: 'Tipo de treino',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _workoutNameController,
                    decoration: InputDecoration(
                      helperText: 'Nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _workoutMuscleGroupController,
                    decoration: InputDecoration(
                      helperText: 'Grupo muscular',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _workoutRepsController,
                    decoration: InputDecoration(
                      helperText: 'Repetções',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(
                        'email: ${widget.email}, tipoTreino: ${_workoutTypeController.text}, exercicios: nome: ${_workoutNameController.text} grupoMuscularAlvo: ${_workoutMuscleGroupController.text}, repeticoes: ${_workoutRepsController.text},',
                      );
                      BlocProvider.of<WorkoutBloc>(context).add(
                        CreateWorkoutEvent(
                          email: widget.email,
                          tipoTreino: _workoutTypeController.text,
                          body: {
                            'exercicios': {
                              'nome': _workoutNameController.text,
                              'grupoMuscularAlvo':
                                  _workoutMuscleGroupController.text,
                              'repeticoes': _workoutRepsController.text,
                            }
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: 140.0,
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
