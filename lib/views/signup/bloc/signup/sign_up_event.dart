part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpUserEvent extends SignUpEvent {
  final String name;
  final String email;

  const SignUpUserEvent({required this.name, required this.email});

  @override
  List<Object> get props => [name, email];
}
