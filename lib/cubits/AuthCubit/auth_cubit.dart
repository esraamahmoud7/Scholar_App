import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


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

  Future<void> RegisterUser({required String Email, required String Password}) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredental = await FirebaseAuth.instance
          .createUserWithEmailAndPassword
        (email: Email!, password: Password!);
      print(userCredental.user!.email);
      emit(RegisterSuccess());
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('The account already exists for that email.'));
      }
    }
    on Exception catch(e)
    {
      emit(RegisterFailure('Something went wrong'));
    }
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   // TODO: implement onChange
  //   super.onChange(change);
  //
  //   print(change);
  // }


}
