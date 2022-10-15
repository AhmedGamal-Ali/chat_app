import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/page/RegisterPage.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  userRegister({required String email, required String password}) async {
    emit(RegisterLoding());
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailuer(messageError: "Weak Password"));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailuer(messageError: "email-already-in-use"));
      }
    } catch (ex) {
      emit(RegisterFailuer(messageError: "something wrong"));
    }
  }
}
