import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Auth/authFetch.dart';
import 'package:sampleproject/Database/CourseData.dart';
import 'package:sampleproject/getScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authScreen extends StatefulWidget {
  var authMode;
  authScreen({required this.authMode});
  @override
  State<authScreen> createState() => _authScreenState();
}

enum AuthMode {
  SignUp,
  Login,
}

class _authScreenState extends State<authScreen> {
  bool showPass = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'userName': '',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/udemy.png',
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Transform.translate(
                      offset: Offset(-100, 0),
                      child: Transform.translate(
                        offset: Offset(
                            widget.authMode != AuthMode.Login ? 40 : 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              widget.authMode != AuthMode.Login
                                  ? 'Create account now'
                                  : 'Login now',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      constraints: BoxConstraints(
                        minHeight: widget.authMode == AuthMode.SignUp ? 20 : 0,
                        maxHeight: widget.authMode == AuthMode.SignUp ? 120 : 0,
                      ),
                      child: widget.authMode == AuthMode.SignUp
                          ? TextFormField(
                              enabled: widget.authMode == AuthMode.SignUp,
                              decoration: InputDecoration(
                                hintText: 'User Name',
                                prefixIcon: Icon(FontAwesomeIcons.user),
                                label: Text('User Name'),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(15),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Invalid password!';
                                }
                              },
                              onSaved: (val) {
                                _authData['userName'] = val.toString();
                              },
                            )
                          : null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        prefixIcon: Icon(FontAwesomeIcons.at),
                        label: Text('E-mail'),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty || !val.contains('@')) {
                          return 'Invalid email !';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _authData['email'] = val.toString();
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        focusColor: Colors.red,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        label: Text('Password'),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15),
                        suffixIcon: IconButton(
                          icon: showPass
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              showPass == false
                                  ? showPass = true
                                  : showPass = false;
                            });
                          },
                        ),
                      ),
                      obscureText: showPass,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val!.isEmpty || val.contains(' ')) {
                          return 'Invalid password!';
                        } else if (val.length < 5) {
                          return 'short password';
                        }
                      },
                      onSaved: (val) {
                        _authData['password'] = val.toString();
                      },
                    ),
                    isLoading == false
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(35),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  onPressed: _submit,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    // padding: EdgeInsets.all(20),
                                    child: Text(
                                      widget.authMode != AuthMode.Login
                                          ? 'SING UP'
                                          : 'LOGIN',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    widget.authMode == AuthMode.Login
                                        ? widget.authMode = AuthMode.SignUp
                                        : widget.authMode = AuthMode.Login;
                                  });
                                }),
                                child: Text(
                                  widget.authMode == AuthMode.Login
                                      ? 'SING UP'
                                      : 'LOGIN',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Transform.translate(
                            offset: Offset(0, 30),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
    }

    ///
    SharedPreferences s1 = await SharedPreferences.getInstance();

    ///
////

    setState(() {
      isLoading = true;
    });
    try {
      if (widget.authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'] as String,
          _authData['password'] as String,
        );

        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        /////
        ////////////////////////
        s1.setString('key', '${x[0].Id}');
        s1.setBool('fetch', true);

        /////////////////////
        ///
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => getScreen(idKey: s1.getString('key'))),
          ),
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['email'] as String,
          _authData['password'] as String,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        ////////////////
        ////////////////////////////////////
        ///////////
        s1.setString('key', '${x[0].Id}');
        s1.setBool('fetch', true);

        ///////////////////////
        //////////
        ///

        ///
        ////
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => getScreen(idKey: s1.getString('key'))),
          ),
        );

        ///
        ///

        await FirebaseFirestore.instance
            .collection('newAccount')
            .doc('${x[0].Id}')
            .collection('user')
            .doc('personalInf')
            .set({
          'userName': _authData['userName'],
          'email': _authData['email']!,
          'password': _authData['password']!,
          'image_url': '',
        });

        for (int i = 0; i < CourseData.length; i++) {
          await FirebaseFirestore.instance
              .collection('newAccount')
              .doc('${x[0].Id}')
              .collection('items')
              .doc('${i}')
              .set({'id': ''});
        }

        ////
        //

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => getScreen(
                  idKey: s1.getString('key'),
                )),
          ),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = 'Authenticatio Faild';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      showErrorDialog(errorMessage);
    }
  }

  bool isLoading = false;
  showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                // isLoading = true;
              });
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}
