import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_progress/models/workout/workout.dart';
import 'package:load_progress/views/home/bloc/get_workouts_bloc.dart';

class WorkoutPage extends StatefulWidget {
  final String treonoId;

  const WorkoutPage({super.key, required this.treonoId});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Workout?>? workouts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<GetWorkoutsBloc, GetWorkoutsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetWorkoutsLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 600.0,
                      child: ListView.builder(
                        itemCount: state.workouts.firstWhere((workout) => workout!.treinoId == widget.treonoId)!.exercicios.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.workouts.firstWhere((element) => element!.treinoId == widget.treonoId)!.exercicios[index].nome,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Text(
                                state.workouts.firstWhere((element) => element!.treinoId == widget.treonoId)!.exercicios[index].repeticoes,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
