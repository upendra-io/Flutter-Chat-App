import 'package:chat_app/models/contacts.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/resources/firebase_methods.dart';
import 'package:chat_app/utils/universal_variables.dart';
import 'package:chat_app/widgets/appbar.dart';
import 'package:chat_app/widgets/contact_view.dart';
import 'package:chat_app/widgets/new_chat.dart';
import 'package:chat_app/widgets/quiet_box.dart';
import 'package:chat_app/widgets/user_circle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: null,
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/search_screen");
          },
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final FirebaseMethods firebaseMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseMethods.fetchContacts(
          userId: userProvider.getUser.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var docList = snapshot.data.documents;

            if (docList.isEmpty) {
              return QuietBox();
            }
            return ListView.separated(
              separatorBuilder: (context, index) {
                Divider(
                  color: Colors.black,
                  indent: 10.0,
                );
              },
              padding: EdgeInsets.all(10),
              itemCount: docList.length,
              itemBuilder: (context, index) {
                Contact contact = Contact.fromMap(docList[index].data);

                return ContactView(contact);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
