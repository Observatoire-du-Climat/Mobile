import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserNotConnected()) {
    on<RegisterRequest>(_onRegister);
    on<LoginRequest>(_onLogin);
    on<UserRequest>(_onUserRequest);
    on<LogoutRequest>(_onLogoutRequest);
    on<UserUpdateRequest>(_onUserUpdateRequest);
  }


  Future<void> _onRegister(RegisterRequest request, Emitter<UserState> emit) async {
    print("appel a onRegister dans bloc");
    emit(UserLoading());

    try {
      final User user = await _userRepository.createUser(request.name, request.email, request.password);
      print("compte créé");
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      print("création ratée");
      emit(UserError('Creation de compte ratée'));
    }
  }

  Future<void> _onLogin(LoginRequest request, Emitter<UserState> emit) async {
    print("appel a onLogin dans le bloc");
    emit(UserLoading());

    try {
      final User user = await _userRepository.loginUser(request.email, request.password);
      print("user connecté");
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      print("Login ratééééé");
      print('Exception : $e');
      emit(UserError('Login raté'));
    }
  }

  Future<void> _onUserRequest(UserRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final User user = await _userRepository.getCurrentUser();
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      print('Error : $e');
      emit(UserError('UserRequest raté'));
    }
  }

  Future<void> _onLogoutRequest(LogoutRequest request, Emitter<UserState> emit) async {
    emit(UserDisconnected());
    await _userRepository.logout();
    emit(UserNotConnected());
  }

  Future<void> _onUserUpdateRequest(UserUpdateRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final User user = await _userRepository.updateUser(request.name, request.email, request.password);
      emit(UserUpdated());
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      print('Error : $e');
      emit(UserError('Failed to update user'));
    }
  }
}