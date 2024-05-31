import 'package:notes_app/providers/state/login_states.dart';
import 'package:notes_app/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  Future<bool> login(String email, String password) async {
    state = const LoginStateLoading();

    try {
      await ref.read(authRepositoryProvider).login(email, password);
      state = const LoginStateSuccess();
      return true; // Login successful
    } catch (e) {
      state = LoginStateError(e.toString());
      return false; // Login failed
    }
  }
}


final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});

