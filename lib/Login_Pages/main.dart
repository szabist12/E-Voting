import 'package:app/Admin_Profile/Admin_home.dart';
import 'package:app/Admins.dart';
import 'package:app/Splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../apiController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'E-Voting System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreen(),
      routes: {'/': (context) => const SplashScreen()},
    );
  }
}

// void main() {
//   Admins sampleUser = Admins(
//     Id_: 1,
//     First_Name: 'John',
//     Last_Name: 'Doe',
//     E_Mail: 'john.doe@example.com',
//     Password: 'password123',
//     Cnic: '1234567890',
//     Phone_No: '123-456-7890',
//   );
//
//   runApp(MyApp(sampleUser: sampleUser));
// }
//
// class MyApp extends StatelessWidget {
//   final Admins sampleUser;
//
//   MyApp({required this.sampleUser});
//
//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       navigatorKey: navigatorKey,
//       debugShowCheckedModeBanner: false,
//       title: 'E-Voting System',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routes: {
//         '/': (context) => Admin_Home(sampleUser)
//       },
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final apiController apicontroller = apiController();

  void _submitform() async {
    // if (_formKey.currentState!.validate()) {
    // apicontroller.loginAdmins(c.text, e.text, p.text,context);
    if (c.text == '123' && p.text == 'admin') {
      print("yes");
      final Admins user = Admins.fromJson({
        "First_Name": "abc",
        "Last_Name": "xyz",
        "E_Mail": "abc@xyz",
        "Cnic": "1234567890",
        "Phone_No": "123",
        "Password": "admin"
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Admin_Home(user)),
      );
    } else {
      print("wrong");
    }
    // }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      return 'Please enter an email';
    }
    RegExp cnicRegExp = RegExp(r'^\d{5}-\d{7}-\d{1}$');
    if (!cnicRegExp.hasMatch(value)) {
      return 'Please enter a valid CNIC';
    }
    return null;
  }

  var e = TextEditingController();

  var p = TextEditingController();

  var c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Container(
      //
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         Color(0xffbfbfbf),
      //         Color(0xffFFFFFF),
      //
      //
      //
      //
      //       ],
      //         begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     )
      //   ),
      //  child:
      Form(
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
                      child: Image.asset("assets/images/positive-vote.png"),
                    ),

                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(21),
                    //       bottomRight: Radius.circular(21)),
                    // ),

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
                                      text: 'Welcomed! ',
                                      style: TextStyle(color: Colors.black)),
                                ])),
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
                        )
                      ],
                    ),

                    Container(height: 5),
                    const Wrap(
                      children: [
                        Text(
                          'Login to your account and start viewing candidate profiles and cast vote for your better future',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.grey),
                        )
                      ],
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
                    // TextFormField(
                    //     keyboardType: TextInputType.emailAddress,
                    //     controller: e,
                    //     decoration: InputDecoration(
                    //       focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(21),
                    //           borderSide:
                    //               BorderSide(color: Colors.black45, width: 2)),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(21),
                    //           borderSide: BorderSide(
                    //             color: Colors.blue,
                    //           )),
                    //       prefixIcon: Icon(Icons.person),
                    //       hintText: "Enter Email",
                    //     ),
                    //     validator: _validateEmail),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Please enter a password');
                        }
                        return null;
                      },
                    ),
                    Container(height: 12),

                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          _submitform(); // Call your form submission logic
                          // }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    // Container(
                    //
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       InkWell(
                    //           onTap: () {
                    //             print('Text Cliced');
                    //           },
                    //           child: Text(
                    //             'Forget Password?',
                    //             style: TextStyle(fontWeight: FontWeight.w500),
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // // Add some spacing between the buttons and the "OR" text
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: Divider(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8),
                    //       child: Text('OR', style: TextStyle(fontSize: 16)),
                    //     ),
                    //     Expanded(
                    //       child: Divider(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 16),

                    // Container(
                    //   height: 40,
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.green,
                    //       ),
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => SignUpPage('')
                    //             ));
                    //       },
                    //       child: Text(
                    //         'Sign up',
                    //       ))
                    //   ,
                    // ),
                    // Container(height: 10),
                  ],
                ),
              )),
        ),
      ),
      //  )
    );
  }
}
