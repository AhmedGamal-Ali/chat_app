import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  userLogin({required String email, required String password}) async {
    emit(LoginLoding());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailuer(messageError: "User not Found"));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailuer(messageError: "Wrong password"));
      }
    } catch (ex) {
      emit(LoginFailuer(messageError: "something is wrong"));
    }
  }
}
