import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokoku/models/user_model.dart';
import 'package:tokoku/services/auth_service.dart';
import 'package:tokoku/services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp({
    required String namaToko,
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUp(
        namaToko: namaToko,
        email: email,
        password: password,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getCurrentUser(id);
      print(user);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
