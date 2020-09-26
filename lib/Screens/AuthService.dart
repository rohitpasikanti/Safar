import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test2/Screens/Login.dart';
import 'package:flutter_test2/Screens/Welcomescr.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return WelcomScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signInWithOtp(smscode, varID) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: varID, smsCode: smscode);
    signIn(authCredential);
  }
}
