part of 'get_user_bloc.dart';

sealed class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserRemoteSourceEvent extends GetUserEvent {
  final String name; 

  const GetUserRemoteSourceEvent({required this.name});

  @override
  List<Object> get props => [name];
}
