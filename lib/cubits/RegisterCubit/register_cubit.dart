import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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
}
