part of 'get_workouts_bloc.dart';

sealed class GetWorkoutsState extends Equatable {
  const GetWorkoutsState();
  
  @override
  List<Object> get props => [];
}

final class GetWorkoutsInitialState extends GetWorkoutsState {
  const GetWorkoutsInitialState();
}

final class GetWorkoutsLoadingState extends GetWorkoutsState {
  const GetWorkoutsLoadingState();
}

final class GetWorkoutsLoadedState extends GetWorkoutsState {
  final List<Workout?> workouts;

  const GetWorkoutsLoadedState(this.workouts);

  @override
  List<Object> get props => [workouts];
}

final class GetWorkoutsFailureState extends GetWorkoutsState {
  final String message;

  const GetWorkoutsFailureState(this.message);

  @override
  List<String> get props => [message];
}
