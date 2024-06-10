import 'dart:math';

import 'package:flutter/material.dart';

import '../apiController.dart';

class forgetpassword extends StatefulWidget {
  forgetpassword({super.key, required this.type});
  String type;

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cnic = TextEditingController();
  String gotp = '';

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

  String feedback = '';
  bool _passwordVisible = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forget Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  "The First 3 digits of otp is send to your email and last 3 digits to yours mobile number",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cnic,
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
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (cnic.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter Cnic"),
                          ),
                        );
                      } else if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Cnic not validate"),
                          ),
                        );
                      } else {
                        final random = Random();
                        final randomNumber =
                            random.nextInt(999999 - 100000) + 100000;
                        gotp = randomNumber.toString();
                        Map data = {};
                        if (widget.type == "u") {
                          data =
                          await Apihelper.getonevoter(cnic.text, context);
                        } else {
                          data = await Apihelper.getonecandidate(
                              cnic.text, context);
                        }
                        if (data.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("user not found"),
                            ),
                          );
                        } else {
                          await Apihelper.sendotp(
                              randomNumber.toString().substring(0, 3),
                              randomNumber.toString().substring(3, 6),
                              data['E_Mail'],
                              data['Phone_No'],
                              context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("otp is send"),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Get Otp",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: otp,
                  maxLength: 6,
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
                    hintText: "Enter your OTP",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide:
                        const BorderSide(color: Colors.black45, width: 2)),
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
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (otp.text != gotp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid OTP"),
                          ),
                        );
                      } else if (password.text.isEmpty || cnic.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("fill all fields"),
                          ),
                        );
                      } else if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("validate all things"),
                          ),
                        );
                      } else {
                        bool c = false;
                        if (widget.type == "u") {
                          c = await Apihelper.updatepasswordvoter(
                              cnic.text, password.text, context);
                        } else {
                          c = await Apihelper.updatepasswordcandidate(
                              cnic.text, password.text, context);
                        }
                        if (c) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password updated"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password not updated"),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "update Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
