import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_app/widgets/chatBubble.dart';
import '../Constants.dart';
import '../models/message.dart';



class chatPage extends StatelessWidget {
   chatPage({super.key});

   static String id='ChatPage';
   final CollectionReference message = FirebaseFirestore.instance.collection(KMessagesCollections);
   TextEditingController _controller=TextEditingController();
   final controller=ScrollController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(KCreatedAt,descending: true).snapshots(),
      builder: (context,snapShot)
      {
        if(snapShot.hasData)
          {
            List<Message> messagesList = [];
            for (int i = 0; i < snapShot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapShot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: KPrimaryColor,
                title: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image.asset(Klogo,height: 50,),Text('Chat')],),
              ),
              body:Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: messagesList.length,
                        itemBuilder: (context,index)
                        {
                          if(messagesList[index].id==email)
                            {
                              return chatBubble(color: KPrimaryColor,message: messagesList[index],position: Alignment.centerLeft);
                            }
                          else
                            {
                              return chatBubble(color: Color(0xff006D84),message: messagesList[index],position: Alignment.centerRight);
                            }
                        }

                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onSubmitted: (data){
                        message.add({
                          KMessage: data,
                          KCreatedAt: DateTime.now(),
                          'id' : email,
                        });
                        _controller.clear();
                        controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration
                        (
                          suffixIcon: Icon(
                            Icons.send,
                            color:KPrimaryColor,
                          ),
                          hintText:" Send Message...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: KPrimaryColor),
                            borderRadius: BorderRadius.circular(8),
                          )
                      ),
                    ),
                  )

                ],
              ),

            );
          }
        else
          {
            return Text('Loading....');
          }
      },

    );
  }
}