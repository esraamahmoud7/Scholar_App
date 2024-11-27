import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/Constants.dart';
import 'package:scholar_app/cubits/RegisterCubit/register_cubit.dart';

import '../helper/showSnakeBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/textField.dart';
import 'Login.dart';
import 'chatPage.dart';


class RegisterPage extends StatelessWidget {
   RegisterPage({super.key});

  static String id="RegisterPage";

  String? Email,Password;

  GlobalKey<FormState> formKey=GlobalKey();

  bool isLoading=false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is RegisterLoading)
    {
      isLoading= true;
    }
    else if(state is RegisterSuccess)
    {
      isLoading = false;
      showSnakeBar(context, "Register Successfully.");
      Navigator.pop(context);
    }
    else if(state is RegisterFailure)
    {
      showSnakeBar(context, state.Message);
      isLoading = false;
    }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 100,),
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
                  child: Text("Sign Up",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Pacifico'
                    ) ,),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 20),
                  child: CustFormTextField(hint:"Email",onChanged: (data){ Email=data;},invisible: false,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustFormTextField(hint:"Password",onChanged: (data){ Password=data; },invisible: true,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(text: "Sign Up",
                    OnTap: () async {
                      if (formKey.currentState!.validate())
                      {
                        BlocProvider.of<RegisterCubit>(context).RegisterUser(Email: Email!, Password: Password!);
                      }
                    }

                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already have an account? ",style: TextStyle(color: Colors.white),),
                    GestureDetector
                      (
                        onTap: (){Navigator.pop(context);},
                        child: Text(' Sign In',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white))
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