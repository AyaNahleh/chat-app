import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {

   final fbm= FirebaseMessaging.instance;
   fbm.requestPermission();
   FirebaseMessaging.onMessage.listen((message) {
     print(message);
     return;
   });
   FirebaseMessaging.onMessageOpenedApp.listen((message) {
     print(message);
     return;
   });
   fbm.subscribeToTopic('chat');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Logout'),
                        ],
                      ),
                    ))
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),

    );
  }
}
