import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:load_progress/models/user/user.dart';
import 'package:load_progress/services/user/user_service.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final UserService service = UserService();

  GetUserBloc() : super(GetUserInitialState()) {
    on<GetUserRemoteSourceEvent>((event, emit) async {
      emit(GetUserInitialState());
      emit(GetUserLoadingState());
      final response = await service.getUser(event.name);

      if(response != null) {
        emit(GetUserLoadedState(user: response));
      } else {
        const String error = 'Usuário não cadastrado';
        emit(const GetUserFailureState(error: error));
      }
    });
  }
}
