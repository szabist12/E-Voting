import 'dart:core';
import 'package:app/Login_Pages/Voter_Login.dart';
import 'package:flutter/material.dart';

import '../apiController.dart';

class VoterSignUpPage extends StatefulWidget {
  VoterSignUpPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _VoterSignUpPageState createState() => _VoterSignUpPageState();
}

class _VoterSignUpPageState extends State<VoterSignUpPage> {
  final apiController apicontroller = apiController();
  Future _submitform2() async {
    if (_formKey.currentState!.validate()) {
      if (p.text != cp.text) {
        ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
          const SnackBar(content: Text('Password does not match')),
        );
      } else {
        apicontroller.insertVoterData(
            first_name.text, last_name.text, c.text, num.text, e.text, p.text);
        ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
            const SnackBar(content: Text('Signed up Successfully')));
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String feedback = '';
  bool _passwordVisible = false;

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid E-mail';
    }
    return null;
  }

  String? _validateCNIC(value) {
    if (value!.isEmpty) {
      return 'Please enter an CNIC';
    }
    RegExp cnicRegExp = RegExp(r'^\d{5}-\d{7}-\d{1}$');
    if (!cnicRegExp.hasMatch(value)) {
      return 'Please enter a valid CNIC';
    }
    return null;
  }

  String? _validateContact(value) {
    if (value!.isEmpty) {
      return 'Please enter contact number';
    }
    RegExp contactRegExp = RegExp(r'^\d{4}-?\d{7}$');
    if (!contactRegExp.hasMatch(value)) {
      return 'Please enter a valid contact number';
    }
    return null;
  }

  String? _validateStrongpassword(value) {
    if (value!.isEmpty) {
      return 'Please enter Password';
    }
    RegExp strongpasswordRegExp =
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$');

    if (!strongpasswordRegExp.hasMatch(value)) {
      return 'Please enter a Strong Password';
    }
    return null;
  }

  var e = TextEditingController();

  var p = TextEditingController();
  var cp = TextEditingController();

  var c = TextEditingController();

  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var num = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
              margin: const EdgeInsets.all(20),
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(21),
                            bottomRight: Radius.circular(21)),
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/images/positive-vote.png"),
                        ],
                      ),
                    ),
                    Container(height: 12),
                    const Text(
                      "WE-VOTE",
                      style: TextStyle(
                        color: Color(0xff937DE2),
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        fontFamily: 'Mainn',
                      ),
                    ),
                    Container(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Mainn',
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Register ',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: (50))),
                                ])),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Mainn',
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Yourself! ',
                                      style: TextStyle(color: Colors.black)),
                                ])),
                      ],
                    ),
                    Container(height: 10),
                    const Row(
                      children: [
                        Text(
                          'Sign up Here',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Container(height: 5),
                    const Wrap(
                      children: [
                        Text(
                          'Sign up your account and start viewing candidate profiles and cast vote for your better future',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.grey),
                        )
                      ],
                    ),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: first_name,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )),
                        prefixIcon: const Icon(Icons.person_2),
                        hintText: "Enter your First Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Please enter your first name');
                        }
                        return null;
                      },
                    ),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: last_name,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )),
                        prefixIcon: const Icon(Icons.person_2),
                        hintText: "Enter your Last Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Please enter your last name');
                        }
                        return null;
                      },
                    ),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: num,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )),
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "Enter your phone number",
                      ),
                      validator: _validateContact,
                    ),
                    Container(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: c,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                  color: Colors.black45, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              )),
                          prefixIcon: const Icon(Icons.add_card),
                          hintText: "Enter your CNIC",
                        ),
                        validator: _validateCNIC),
                    Container(height: 12),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: e,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                  color: Colors.black45, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              )),
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Enter Email",
                        ),
                        validator: _validateEmail),
                    Container(height: 12),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: p,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintText: "Enter password",
                      ),
                      obscureText: !_passwordVisible,
                      // Toggle password visibility
                      validator: _validateStrongpassword,
                      onChanged: (value) {
                        bool isStrong = _validateStrongpassword(value) == null;
                        setState(() {
                          feedback = isStrong
                              ? 'Password is strong.'
                              : 'Password is not strong enough. Include at least one lowercase, one uppercase, one digit, one special character, and be at least 8 characters long.';
                        });
                      },
                    ),
                    Text(
                      feedback,
                      style: TextStyle(
                        color: feedback.contains('not strong')
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),

                    Container(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: cp,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintText: "Enter password Again",
                      ),
                      obscureText:
                      !_passwordVisible, // Toggle password visibility
                    ),

                    Container(height: 12),

                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitform2,
                        child: const Text('Sign up'),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Add some spacing between the buttons and the "OR" text
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('OR', style: TextStyle(fontSize: 16)),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VoterLoginPage(),
                                ));
                          },
                          child: const Text(
                            'Login',style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Container(height: 10),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
