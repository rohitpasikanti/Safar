import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test2/Screens/Welcomescr.dart';
import 'package:flutter_test2/Utilities/design.dart';
import 'package:flutter_test2/Screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test2/Loaders/SignUpLoad.dart';
import 'package:flutter_test2/Screens/AuthService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  String phoneNo, verificationID, smsSent;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _rememberMe = false;
  bool codeSent = false;

  Widget _buildEmailTF() {
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
                return 'Please Enter Your Email';
              } else if (!input.contains('@')) {
                return 'Invalid Email';
              } else {
                return null;
              }
            },
            onSaved: (input) => _email = input,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_android,
                color: Colors.green[300],
              ),
              hintText: 'Enter your Phone Number',
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
            validator: (input) {
              if (input.isEmpty) {
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: rLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.green[50],
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: rLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          verifyPhone(_email);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.green[300],
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: rLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        debugPrint('Sign Up Button Pressed');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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

  Future<void> signIn() async {
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
            .signInWithEmailAndPassword(email: _email, password: _password);

        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomScreen()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        print(e.code);
        if (e.code == 'wrong-password') {
          _showErrorDialog('Incorrect Password');
        } else if (e.code == 'invalid-email') {
          _showErrorDialog('Incorrect Email Id');
        } else if (e.code == 'user-not-found') {
          _showErrorDialog('Email Id is not registed');
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
                      //       Color(0xFFFFFFEE),
                      //       Color(0xFFFFFFEE),
                      //       //Color(0xFFFFFFEE),
                      //       //Color(0xFFFFFFEE),
                      //     ],

                      //     //stops: [0.1, 0.4, 0.7, 0.9],
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
                              'Sign In',
                              style: TextStyle(
                                color: Colors.green[400],
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _buildEmailTF(),
                            SizedBox(
                              height: 30.0,
                            ),
                            _buildPasswordTF(),
                            _buildForgotPasswordBtn(),
                            _buildRememberMeCheckbox(),
                            _buildLoginBtn(),
                            _buildSignInWithText(),
                            _buildSocialBtnRow(),
                            _buildSignupBtn(),
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
