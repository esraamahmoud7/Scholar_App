import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_app/Screens/chatPage.dart';
import 'package:scholar_app/cubits/AuthCubit/auth_cubit.dart';
import 'Blocs/auth_bloc.dart';
import 'Screens/Login.dart';
import 'Screens/Register.dart';
import 'SimpleBlocObserver.dart';
import 'cubits/ChatCubit/chat_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer;
  // Bloc.transformer;
  // BlocOverrides.runZoned(() {
  //   runApp(MyApp());
  // },
  //     blocObserver: SimpleBlocObserver()
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ChatCubit()),
        BlocProvider(create: (context)=>AuthCubit()),
        BlocProvider(create: (context)=>AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          SigninPage.id: (context) => SigninPage(),
          chatPage.id: (context) => chatPage(),
        },
        initialRoute: SigninPage.id,
        // home: SigninPage(),
      ),
    );
  }
}
