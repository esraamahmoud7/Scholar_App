import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  Future<void> LoginUser({required String Email,required String Password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredental = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email!, password: Password!);
      print("success");
      emit(LoginSuccessfully());


    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure("user-not-found"));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure("wrong-password"));
      }
    }
    on Exception catch(e)
    {
      emit(LoginFailure("Something went wrong"));
    }
  }



}
