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
    emit(UserLoading());

    try {
      final User user = await _userRepository.createUser(request.name, request.email, request.password);
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      emit(UserError('La création du compte a échoué'));
    }
  }

  Future<void> _onLogin(LoginRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final User user = await _userRepository.loginUser(request.email, request.password);
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      emit(UserError("L'authentification a échoué"));
    }
  }

  Future<void> _onUserRequest(UserRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final User user = await _userRepository.getCurrentUser();
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      emit(UserError('La récupération du compte a échoué'));
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
      emit(UserError('La modification du compte a échoué'));
    }
  }
}