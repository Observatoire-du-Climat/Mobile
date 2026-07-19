import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/user_event.dart';
import 'package:mobile/bloc/user_state.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/repositories/user_repository.dart';

/// Handles user-related events and application states.
///
/// This BLoC coordinates user retrieval, creation, authentication and update through the [UserRepository].
class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _userRepository;

  /// Creates a user BLoC and registers all supported event handlers.
  UserBloc(this._userRepository) : super(UserNotConnected()) {
    on<RegisterRequest>(_onRegister);
    on<LoginRequest>(_onLogin);
    on<UserRequest>(_onUserRequest);
    on<LogoutRequest>(_onLogoutRequest);
    on<UserUpdateRequest>(_onUserUpdateRequest);
  }

  /// Handles the registration of a new user.
  Future<void> _onRegister(RegisterRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final User user = await _userRepository.createUser(request.name, request.email, request.password);
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      emit(UserError('La création du compte a échoué'));
    }
  }

  /// Handles the authentication of a user.
  Future<void> _onLogin(LoginRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final User user = await _userRepository.loginUser(request.email, request.password);
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      emit(UserError("L'authentification a échoué"));
    }
  }

  /// Handles the retrieval of the current user data.
  Future<void> _onUserRequest(UserRequest request, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final User user = await _userRepository.getCurrentUser();
      emit(UserConnected(name: user.name, email: user.email, isValid: user.isValid));
    } catch (e) {
      emit(UserError('La récupération du compte a échoué'));
    }
  }

  /// Handles the log out of the current user.
  Future<void> _onLogoutRequest(LogoutRequest request, Emitter<UserState> emit) async {
    emit(UserDisconnected());
    await _userRepository.logout();
    emit(UserNotConnected());
  }

  /// Handles the update of the current user data.
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