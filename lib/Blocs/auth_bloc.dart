import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit)async {
      if(event is LoginEvent)
        {
          emit(LoginLoading());
          try {
              UserCredential userCredental = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: event.Email!, password: event.Password!);
              print("success");
              emit(LoginSuccessfully());
          }
          on FirebaseAuthException catch (e) {
            emit(LoginFailure("Email or Password is wrong please enter correct one"));
          }
          on Exception catch(e)
          {
            emit(LoginFailure("Something went wrong"));
          }
        }
      else if(event is RegisterEvent)
        {
            emit(RegisterLoading());
            try {
                UserCredential userCredental = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword
                  (email: event.Email!, password: event.Password!);
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


    );

  }

  // void onTransition(Transition<AuthEvent,AuthState> transition)
  // {
  //   super.onTransition(transition);
  //   print(transition);
  // }

}
