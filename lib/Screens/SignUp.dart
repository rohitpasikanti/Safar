import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test2/Screens/AuthService.dart';
import 'package:flutter_test2/Screens/Login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test2/Screens/OtpVerify.dart';
import 'package:flutter_test2/Utilities/design.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test2/Loaders/SignUpLoad.dart';
import 'package:flutter_test2/Screens/AuthService.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  String _email, _password, _moboleno;
  String phoneNo, verificationID, smsSent;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool codeSent = false;

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: rLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecoration,
          height: 50.0,
          child: TextFormField(
            validator: (input) {
              if (input.isEmpty) {
                return 'Please Enter Your Name';
              } else {
                return null;
              }
            },
            onSaved: (input) => _email = input,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.green[300],
              ),
              hintText: 'Enter your Name',
              hintStyle: rHintText,
            ),
          ),
        ),
      ],
    );
  }

  List<String> lst = ['Male', 'Female', 'Others'];
  int _selectedposition = 0;

  void changeIndex(int index) {
    setState(() {
      _selectedposition = index;
    });
  }

  Widget _buidGenderBtn(String txt, int index) {
    return FlatButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
            color: _selectedposition == index
                ? Colors.green[300]
                : Colors.black12),
      ),
      child: Text(txt,
          style: TextStyle(
              color:
                  _selectedposition == index ? Colors.green[300] : Colors.black,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: rLabelStyle,
        ),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            _buidGenderBtn(lst[0], 0),
            SizedBox(
              width: 20.0,
            ),
            _buidGenderBtn(lst[1], 1),
            SizedBox(
              width: 20.0,
            ),
            _buidGenderBtn(lst[2], 2),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: rLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecoration,
          height: 50.0,
          child: TextFormField(
            validator: (input) {
              if (input.isEmpty) {
                return 'Please Enter Your Email';
              } else if (!input.contains('@')) {
                return 'Invalid Email';
              } else {
                return null;
              }
            },
            onSaved: (input) => _email = input,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.green[300],
              ),
              hintText: 'Enter your Email',
              hintStyle: rHintText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: rLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecoration,
          height: 50.0,
          child: TextFormField(
            validator: (input) {
              if (input.isEmpty) {
                return 'Please Enter Your Phone No';
              } else {
                return null;
              }
            },
            onSaved: (input) => _moboleno = input,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.green[300],
              ),
              hintText: 'Enter your Phone No',
              hintStyle: rHintText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: rLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecoration,
          height: 50.0,
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Your Password';
              } else {
                return null;
              }
            },
            onSaved: (input) => _password = input,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.green[300],
              ),
              hintText: 'Enter your Password',
              hintStyle: rHintText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          codeSent
              ? AuthService().signInWithOtp(smsSent, verificationID)
              : verifyPhone(_moboleno);
          codeSent
              ? Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OtpForm()))
              : Navigator.pop(context);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.green[300],
        child: Text(
          'REGISTER',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginbackBtn() {
    return GestureDetector(
      onTap: () {
        debugPrint('Sign Up Button Pressed');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.green[300],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(_moboleno) async {
    final PhoneVerificationCompleted verified = (AuthCredential authresult) {
      AuthService().signIn(authresult);
    };
    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verID, [int forceResend]) {
      this.verificationID = verID;
      setState(() {
        this.codeSent = true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verID) {
      this.verificationID = verID;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _moboleno,
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeOut,
        timeout: const Duration(seconds: 5));
  }

  Future<void> signUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final formState = _formKey.currentState;
    if (formState.validate()) {
      setState(() {
        loading = true;
      });
      formState.save();
      try {
        UserCredential _userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'weak-password') {
          _showErrorDialog('The account already exists for that email.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showErrorDialog('The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        setState(() => loading = false);
        _showErrorDialog(e.toString());
        print(e.toString());
      }
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
              title: Text('An Error Occured'),
              content: Text(msg),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? ShowLoading()
        : Scaffold(
            body: Form(
              key: _formKey,
              //value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: double.infinity,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     begin: Alignment.topCenter,
                      //     end: Alignment.bottomCenter,
                      //     colors: [
                      //       Color(0xFF73AEF5),
                      //       Color(0xFF61A4F1),
                      //       Color(0xFF478DE0),
                      //       Color(0xFF398AE5),
                      //     ],
                      //     stops: [0.1, 0.4, 0.7, 0.9],
                      //   ),
                      // ),
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 80.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.green[400],
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _buildNameTF(),
                            SizedBox(height: 10.0),
                            _buildGender(),
                            SizedBox(height: 10.0),
                            _buildEmailTF(),
                            SizedBox(height: 10.0),
                            _buildMobileTF(),
                            SizedBox(height: 10.0),
                            _buildPasswordTF(),
                            //_buildForgotPasswordBtn(),
                            //_buildRememberMeCheckbox(),
                            //_buildLoginBtn(),
                            //_buildSignInWithText(),
                            //_buildSocialBtnRow(),
                            _buildRegisterBtn(),
                            _buildLoginbackBtn(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
