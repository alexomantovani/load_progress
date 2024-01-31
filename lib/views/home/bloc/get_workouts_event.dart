part of 'get_workouts_bloc.dart';

sealed class GetWorkoutsEvent extends Equatable {
  const GetWorkoutsEvent();

  @override
  List<Object> get props => [];
}

final class ListWorkoutsEvent extends GetWorkoutsEvent {
  final String usuarioId;

  const ListWorkoutsEvent(this.usuarioId);

  @override
  List<String> get props => [usuarioId];
}
