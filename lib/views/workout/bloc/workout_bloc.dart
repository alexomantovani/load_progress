import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:load_progress/services/workout/workout_service.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutService service = WorkoutService();

  WorkoutBloc() : super(WorkoutInitialState()) {
    on<CreateWorkoutEvent>((event, emit) async {
      emit(WorkoutInitialState());
      emit(WorkoutInitialState());
      final result = await service.createWorkout(
        email: event.email,
        tipoTreino: event.tipoTreino,
        exercicios: [event.body],
      );
      if (result != null) {
        final success = result['success'] as bool?;
        if (success != null) {
          if (success) {
            emit(WorkoutCreatedState(response: result));
          } else {
            emit(const WorkoutFailureState(
                message: 'Não foi possível criar o treino'));
          }
        } else {
          emit(const WorkoutFailureState(message: 'Success value is null'));
        }
      } else {
        print('null');
        emit(const WorkoutFailureState(message: 'Server down'));
      }
    });
  }
}
