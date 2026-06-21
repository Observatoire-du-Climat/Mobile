import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserNotConnected()) {
    on<RegisterRequest>(_onRegister);
    on<LoginRequest>(_onLogin);
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

  Future<void> _onLogin(LoginRequest event, Emitter<UserState> emit) async {
    print("appel a onLogin dans le bloc");
    emit(UserLoading());

    try {
      //await _userRepository.loginUser(event.email, event.password);
      print("user connecté");
      emit(UserConnected());
    } catch (e) {
      print("Login raté");
      emit(UserError('Login raté'));
    }
  }
}