import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_app/models/message.dart';

import '../../Constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  // includes collection --> KMessagesCollections
  final CollectionReference messages = FirebaseFirestore.instance.collection(KMessagesCollections);
  List<Message> messagesList=[];
  void SendMessage({required String message,required String email})
  {
    messages.add({
      KMessage: message,
      KCreatedAt: DateTime.now(),
      'id' : email,
    });
  }

  void ShowMessages()
  {
    messages.orderBy(KCreatedAt,descending: true).snapshots().listen((event){
      messagesList.clear();
        for(var doc in event.docs)
        {
          messagesList.add(Message.fromJson(doc));
        }
        emit(ChatSuccess(messagesList: messagesList));
      }
    );

  }
}
