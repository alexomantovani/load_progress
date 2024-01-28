part of 'get_user_bloc.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();
  
  @override
  List<Object> get props => [];
}

final class GetUserInitialState extends GetUserState {}

final class GetUserLoadingState extends GetUserState {}

final class GetUserLoadedState extends GetUserState {
  final List<User?> user;

  const GetUserLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

final class GetUserFailureState extends GetUserState {
  final String error;

  const GetUserFailureState({required this.error});

  @override
  List<Object> get props => [error];
}

