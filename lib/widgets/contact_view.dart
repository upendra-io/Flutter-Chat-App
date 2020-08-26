import 'package:chat_app/models/contacts.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/resources/firebase_methods.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/universal_variables.dart';
import 'package:chat_app/widgets/cached_image.dart';
import 'package:chat_app/widgets/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final FirebaseMethods firebaseMethods = FirebaseMethods();

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: firebaseMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          return ViewLayout(contact: user);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final FirebaseMethods firebaseMethods = FirebaseMethods();

  ViewLayout({@required this.contact});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    receiver: contact,
                  ))),
      title: Text(
        contact?.name ?? "..",
        style:
            TextStyle(color: Colors.black, fontFamily: "Arial", fontSize: 19),
      ),
      subTitle: Text(
        "Hello",
        style: TextStyle(
          color: UniversalVariables.greyColor,
          fontSize: 14,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 60,
              isRound: true,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: UniversalVariables.onlineDotColor,
                    border: Border.all(color: Colors.white, width: 2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
