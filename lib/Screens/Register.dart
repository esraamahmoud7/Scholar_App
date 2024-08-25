import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/Constants.dart';

import '../helper/showSnakeBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/textField.dart';


class RegisterPage extends StatefulWidget {
   RegisterPage({super.key});

  static String id="RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? Email,Password;

  GlobalKey<FormState> formKey=GlobalKey();

  bool isLoading=false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
                        isLoading=true;
                        setState(() {});
                        try {
                          await RegisterUser();
                          showSnakeBar(
                              context, 'The account created successfully.');
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnakeBar(context,
                                'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnakeBar(context,
                                'The account already exists for that email.');
                          }
                        }
                        catch (e) {
                          print(e);
                          showSnakeBar(context, 'There was an error.');
                        }
                        isLoading=false;
                        setState(() {});
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
  }


  Future<void> RegisterUser() async {
    UserCredential userCredental = await FirebaseAuth.instance
        .createUserWithEmailAndPassword
      (email: Email!, password: Password!);
      print(userCredental.user!.displayName);
  }
}