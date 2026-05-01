import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as develepor;
import 'package:restapi_flutter/data/repositories/auth_repository.dart';
import 'package:restapi_flutter/logic/bloc/auth/auth_event.dart';
import 'package:restapi_flutter/logic/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final token = await repository.getToken();
      if (token != null) {
        emit(Authenticated(token));
      } else {
        emit(Unauthenticated());
      }
    });
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      develepor.log('Attempting login for: ${event.email}', name: 'AuthBloc');
      try {
        await repository.login(event.email, event.password);
        final token = await repository.getToken();

        if (token != null) {
          emit(Authenticated(token));
          develepor.log('Status: Authenticated', name: 'AuthBloc');
        } else {
          throw 'Token tidak ditemukan setelah login';
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        develepor.log('Status: AuthError - $e', name: 'AuthBloc');
      }
    });
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await repository.register(event.name, event.email, event.password);
        emit(Unauthenticated());
        develepor.log('Register Success', name: 'AuthBloc');
      } catch (e) {
        emit(AuthError(e.toString()));
        develepor.log('Register Error: $e', name: 'AuthBloc');
      }
    });
    on<LogoutRequested>((event, emit) async {
      await repository.deleteToken();
      emit(Unauthenticated());
      develepor.log('Logged Out', name: 'AuthBloc');
    });
  }
}
