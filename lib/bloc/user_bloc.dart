import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserNotConnected()) {
    on<RegisterRequest>(_onRegister);
  }


  Future<void> _onRegister(RegisterRequest event, Emitter<UserState> emit) async {
    print("appel a onRegister dans bloc");
    emit(UserLoading());

    try {
      await _userRepository.createUser(event.name, event.email, event.password);
      print("compte créé");
      emit(UserConnected());
    } catch (e) {
      print("création ratée");
      emit(UserError('Creation de compte ratée'));
    }

  }
}