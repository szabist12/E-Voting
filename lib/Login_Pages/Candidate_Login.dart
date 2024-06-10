import 'package:app/SignUp_Pages/Candidate_SignUp.dart';
import 'package:flutter/material.dart';

import '../apiController.dart';
import 'forgetpassword.dart';

class CandidateLoginPage extends StatefulWidget {
  const CandidateLoginPage({super.key});

  @override
  _CandidateLoginPageState createState() => _CandidateLoginPageState();
}

class _CandidateLoginPageState extends State<CandidateLoginPage> {
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
      return 'Please enter an email';
    }
    RegExp cnicRegExp = RegExp(r'^\d{5}-\d{7}-\d{1}$');
    if (!cnicRegExp.hasMatch(value)) {
      return 'Please enter a valid CNIC';
    }
    return null;
  }

  final apiController apicontroller = apiController();

  void _submitform() async {
    if (_formKey.currentState!.validate()) {
      apicontroller.loginCandidates(c.text, e.text, p.text, context);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  var e = TextEditingController();
  var p = TextEditingController();
  var c = TextEditingController();

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
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/images/positive-vote.png"),
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
                              text: 'Here to get ',
                              style:
                              TextStyle(color: Colors.blue, fontSize: 50),
                            ),
                          ],
                        ),
                      ),
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
                              text: 'Welcomed! ',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  const Row(
                    children: [
                      Text(
                        'Login Here',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  const Wrap(
                    children: [
                      Text(
                        'Login to your account and start viewing candidate profiles and cast vote for your better future',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: c,
                    maxLength: 15,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide:
                        const BorderSide(color: Colors.black45, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.add_card),
                      hintText: "Enter your CNIC",
                    ),
                    validator: _validateCNIC,
                  ),
                  Container(height: 12),
                  // TextFormField(
                  //   keyboardType: TextInputType.emailAddress,
                  //   controller: e,
                  //   decoration: InputDecoration(
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(21),
                  //       borderSide:
                  //           const BorderSide(color: Colors.black45, width: 2),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(21),
                  //       borderSide: const BorderSide(
                  //         color: Colors.blue,
                  //       ),
                  //     ),
                  //     prefixIcon: const Icon(Icons.person),
                  //     hintText: "Enter Email",
                  //   ),
                  //   validator: _validateEmail,
                  // ),
                  Container(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: p,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide:
                        const BorderSide(color: Colors.black45, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Please enter a password');
                      }
                      return null;
                    },
                  ),
                  Container(height: 12),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submitform();
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => forgetpassword(type: "c",),
                            ),
                          );
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateSignUpPage(
                                title: '',
                              )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Sign up',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
