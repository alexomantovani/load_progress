import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:load_progress/services/user/user_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserService service =  UserService();

  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpUserEvent>((event, emit) async {
      emit(SignUpInitialState());
      final response = await service.createUser(event.name, event.email);
      emit(SignUpLoadingState());

      if(response != null) {
        if(response['message'] != null) {
          emit(SignUpLoadedState(message: response['message']));
        } else {
          emit(SignUpFailureState(error: response['error']));
        }
      }
      
    });
  }
}
