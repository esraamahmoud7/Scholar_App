import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_app/cubits/ChatCubit/chat_cubit.dart';
import 'package:scholar_app/widgets/chatBubble.dart';
import '../Constants.dart';
import '../models/message.dart';


class chatPage extends StatelessWidget {
  chatPage({super.key});

  static String id = 'ChatPage';
  TextEditingController _controller = TextEditingController();
  final controller = ScrollController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ChatCubit>(context).ShowMessages();
    List<Message> messagesList=[];
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments;
    //streamBuilder for rebuild the UI after data change
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(Klogo, height: 50,), Text('Chat')],),
      ),
      body: Column(
        children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                  return ListView.builder(
                      reverse: true,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        if (messagesList[index].id == email) {
                          return chatBubble(color: KPrimaryColor,
                              message: messagesList[index],
                              position: Alignment.centerLeft);
                        }
                        else {
                          return chatBubble(color: Color(0xff006D84),
                              message: messagesList[index],
                              position: Alignment.centerRight);
                        }
                      }
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).SendMessage(
                    message: data, email: email as String);
                BlocProvider.of<ChatCubit>(context).ShowMessages();
                _controller.clear();
                controller.animateTo(0, duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration
                (
                  suffixIcon: Icon(
                    Icons.send,
                    color: KPrimaryColor,
                  ),
                  hintText: " Send Message...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: KPrimaryColor),
                    borderRadius: BorderRadius.circular(8),
                  )
              ),
            ),
          )

        ],
      ),

    );
  }
}
