import 'package:flutter/material.dart';

class ExerciseComponent extends StatelessWidget {
  const ExerciseComponent({
    super.key,
    required this.exerciseCounter,
    required this.workoutNameController,
    required this.workoutMuscleGroupController,
    required this.workoutRepsController,
  });
  final int exerciseCounter;
  final TextEditingController workoutNameController;
  final TextEditingController workoutMuscleGroupController;
  final TextEditingController workoutRepsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
         Text(
          'Exercicio ${exerciseCounter + 1}',
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: workoutNameController,
          decoration: InputDecoration(
            helperText: 'Nome',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        TextFormField(
          controller: workoutMuscleGroupController,
          decoration: InputDecoration(
            helperText: 'Grupo muscular',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        TextFormField(
          controller: workoutRepsController,
          decoration: InputDecoration(
            helperText: 'Repetções',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }
}
