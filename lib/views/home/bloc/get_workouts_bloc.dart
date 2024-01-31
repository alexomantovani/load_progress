import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:load_progress/models/workout/workout.dart';
import 'package:load_progress/services/workout/workout_service.dart';

part 'get_workouts_event.dart';
part 'get_workouts_state.dart';

class GetWorkoutsBloc extends Bloc<GetWorkoutsEvent, GetWorkoutsState> {
  final WorkoutService service = WorkoutService();

  GetWorkoutsBloc() : super(const GetWorkoutsInitialState()) {
    on<ListWorkoutsEvent>((event, emit) async {
      emit(const GetWorkoutsInitialState());
      emit(const GetWorkoutsLoadingState());

      final result = await service.listWorkouts(event.usuarioId);

      if(result != null) {
        emit(GetWorkoutsLoadedState(result));
      } else {
        emit(const GetWorkoutsFailureState('APIFailure'));
      }
    });
  }
}
