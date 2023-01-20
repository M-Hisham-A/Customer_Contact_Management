import 'package:detailmanagement/repository/repository.dart';
import 'app_event.dart';
import 'app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User_bloc extends Bloc<User_Event, User_state> {
  final UserRepository _userRepository;
  final bool clicked;
  final id;

  User_bloc(this._userRepository, this.clicked, this.id) : super(UserLoad()) {
    on<User_Event>(
      ((event, emit) async {
        emit(UserLoad());
        try {
          if (!clicked) {
            final details = await _userRepository.getUsers();
            emit(UserLoaded(details));
          }
          if (clicked) {
            final details = await _userRepository.getUserDetail(id);
            emit(UserSelected(details));
            print(details);
          }
        } catch (e) {
          emit(UserError(e.toString()));
        }
      }),
    );
  }
}
