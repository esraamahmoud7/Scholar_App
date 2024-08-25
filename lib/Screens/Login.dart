import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_app/Screens/Register.dart';
import 'package:scholar_app/Screens/chatPage.dart';
import 'package:scholar_app/widgets/CustomButton.dart';

import '../Constants.dart';
import '../helper/showSnakeBar.dart';
import '../widgets/textField.dart';


class SigninPage extends StatefulWidget {
  SigninPage({super.key});

  static String id = "LoginPage";

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String? Email,Password;

  bool isLoading=false;

  GlobalKey<FormState> formKey=GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
                      isLoading = true;
                      setState(() {});
                      try {
                        await LoginUser();
                        showSnakeBar(
                            context, "we miss you :').");
                        Navigator.pushNamed(context, chatPage.id,arguments: Email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnakeBar(context,
                              'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnakeBar(context,
                              'Wrong password provided for that user.');
                        }
                      }
                      catch (e) {
                        print(e);
                        showSnakeBar(context, 'There was an error.');
                      }
                      isLoading = false;
                      setState(() {});
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
  }



    Future<void> LoginUser() async {
      UserCredential userCredental = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email!, password: Password!);
      print(userCredental.user!.displayName);
    }
  }
