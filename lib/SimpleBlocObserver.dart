import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_app/cubits/AuthCubit/auth_cubit.dart';

class SimpleBlocObserver extends BlocObserver
{
  @override
  void onTransition(Bloc bloc,Transition transition)
  {
    super.onTransition(bloc,transition);
    print(transition);
  }

  @override
  void onChange(BlocBase bloc,Change change) {
    // TODO: implement onChange
    super.onChange(bloc,change);

    print(change);
  }
}