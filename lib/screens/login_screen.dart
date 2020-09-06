import 'package:chat_app/resources/firebase_repository.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/utils/universal_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPressed = false;
  FirebaseRepository firebaseRepository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: loginButton(),
            ),
            isPressed ? Center(child: CircularProgressIndicator()) : Container()
          ],
        ));
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: UniversalVariables.senderColor,
      child: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text(
          'Login',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        onPressed: () => performLogin(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void performLogin() {
    setState(() {
      isPressed = true;
    });
    firebaseRepository.signIn().then((FirebaseUser user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print('error');
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    firebaseRepository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isPressed = false;
      });
      if (isNewUser) {
        firebaseRepository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
