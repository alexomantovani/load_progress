part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

final class SignUpInitialState extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpLoadedState extends SignUpState {
  final String message;

  const SignUpLoadedState({required this.message});

  @override
  List<Object> get props => [message];
}

final class SignUpFailureState extends SignUpState {
  final String error;

  const SignUpFailureState({required this.error});

  @override
  List<Object> get props => [error];
}
