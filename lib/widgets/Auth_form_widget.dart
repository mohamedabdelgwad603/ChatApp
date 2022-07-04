import 'dart:io';

import 'package:chatapp/widgets/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function _submitAuth;
  final bool isLoading;

  AuthForm(this._submitAuth, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _username = '';
  bool _islogin = true;
  File _userImageFile;

  _pickedImageFn(File pickedImage) {
    _userImageFile = pickedImage;
  }

  _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!_islogin && _userImageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("no image selected"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget._submitAuth(_email.trim(), _password.trim(), _username.trim(),
          _userImageFile, _islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_islogin) UserImagePicker(_pickedImageFn),
                    TextFormField(
                      key: ValueKey("email"),
                      decoration: InputDecoration(labelText: "Email Adress"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val.isEmpty || !val.contains('@')) {
                          return " email is invalid ";
                        }
                        return null;
                      },
                      onSaved: (val) => _email = val,
                    ),
                    if (!_islogin)
                      TextFormField(
                        key: ValueKey("username"),
                        decoration: InputDecoration(labelText: "username"),
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val.isEmpty || val.length < 6) {
                            return " username must be at least 6 characters ";
                          }
                          return null;
                        },
                        onSaved: (val) => _username = val,
                      ),
                    TextFormField(
                      key: ValueKey("password"),
                      decoration: InputDecoration(labelText: "password"),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (val) {
                        if (val.isEmpty || val.length < 6) {
                          return " password must be at least 6 characters ";
                        }
                        return null;
                      },
                      onSaved: (val) => _password = val,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        child: Text(_islogin ? "login" : "sign up"),
                        onPressed: _submit,
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              _islogin = !_islogin;
                            });
                          },
                          child: Text(_islogin
                              ? "Create new account"
                              : "i already have an account"))
                  ],
                ))),
      ),
    );
  }
}
