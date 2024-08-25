import 'package:flutter/material.dart';


class CustFormTextField extends StatelessWidget {
  CustFormTextField({super.key,required this.hint,required this.onChanged,required this.invisible});
  String hint;

  Function(String) onChanged;
  bool invisible;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: invisible,
      validator: (data){
          if(data!.isEmpty)
            {
              return 'Field is required';
            }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide( color: Colors.white,)),
      ),
    );
  }
}

