import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/Screens/Register.dart';
import 'package:scholar_app/Screens/chatPage.dart';
import 'package:scholar_app/cubits/LoginCubit/login_cubit.dart';
import 'package:scholar_app/widgets/CustomButton.dart';

import '../Constants.dart';
import '../cubits/ChatCubit/chat_cubit.dart';
import '../helper/showSnakeBar.dart';
import '../widgets/textField.dart';


class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  static String id = "LoginPage";

  String? Email,Password;

  bool isLoading=false;

  GlobalKey<FormState> formKey=GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state is LoginLoading)
    {
      isLoading= true;
    }
    else if(state is LoginSuccessfully)
    {
      showSnakeBar(context, "we miss you :').");
      Navigator.pushNamed(context, chatPage.id,arguments: Email);
      BlocProvider.of<ChatCubit>(context).ShowMessages();
      isLoading = false;
    }
    else if(state is LoginFailure)
    {
      showSnakeBar(context, state.message);
      isLoading = false;
    }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall:isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 150,),
                Image.asset(Klogo,height: 130,),
                Center(
                  child: Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      )
                  ),
                ),
                SizedBox(height: 50,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Sign In",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'pacifico'
                    ) ,),
                ) ,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 20.0),
                  child: CustFormTextField(hint:"Email",onChanged: (data){Email=data;},invisible: false,),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustFormTextField(hint:"Password",onChanged: (data){Password=data;},invisible: true,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(text: "Sign In",OnTap: ()async
                  {
                    if (formKey.currentState!.validate()) {
                        await BlocProvider.of<LoginCubit>(context).LoginUser(Email: Email!, Password: Password!);
                    }
                  }
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't have an account? ",style: TextStyle(color: Colors.white),),
                    GestureDetector
                      (
                        onTap: (){Navigator.pushNamed(context, RegisterPage.id);},
                        child: Text(' Sign Up',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white))
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
);
  },
);
  }
}
