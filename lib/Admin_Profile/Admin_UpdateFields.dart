import 'package:flutter/material.dart';

import '../Admins.dart';
import '../apiController.dart';

class Admin_FirstNamePage extends StatefulWidget {
  final Admins user;
  const Admin_FirstNamePage(this.user, {super.key});
  @override
  _FirstNamePageState createState() => _FirstNamePageState(user);
}

class _FirstNamePageState extends State<Admin_FirstNamePage> {
  final Admins user;
  _FirstNamePageState(this.user);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String feedback = '';

  var e = TextEditingController();
  var p = TextEditingController();
  var c = TextEditingController();
  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var num = TextEditingController();

  final apiController apicontroller = apiController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      apicontroller.updateFirstNameAdmin(user.Cnic, first_name.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
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
                        bottomRight: Radius.circular(21),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/positive-vote.png'),
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
                              text: 'Edit ',
                              style:
                              TextStyle(color: Colors.blue, fontSize: 30),
                            ),
                            TextSpan(
                              text: 'Profile ',
                              style:
                              TextStyle(color: Colors.black, fontSize: 30),
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
                        'Edit your First Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Container(
                    margin: const EdgeInsets.only(right: 34),
                    child: const Text(
                      'Enter your first name in order to consider your vote',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(height: 20),
                  TextFormField(
                    controller: first_name,
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
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Enter your first name",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  Container(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Save Changes'),
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

class Admin_LastNamePage extends StatefulWidget {
  final Admins user;
  const Admin_LastNamePage(this.user, {super.key});
  @override
  _LastNamePageState createState() => _LastNamePageState(user);
}

class _LastNamePageState extends State<Admin_LastNamePage> {
  final Admins user;
  _LastNamePageState(this.user);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String feedback = '';

  var e = TextEditingController();
  var p = TextEditingController();
  var c = TextEditingController();
  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var num = TextEditingController();

  final apiController apicontroller = apiController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      apicontroller.updateLastNameAdmin(user.Cnic, last_name.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
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
                        bottomRight: Radius.circular(21),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/positive-vote.png'),
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
                              text: 'Edit ',
                              style:
                              TextStyle(color: Colors.blue, fontSize: 30),
                            ),
                            TextSpan(
                              text: 'Profile ',
                              style:
                              TextStyle(color: Colors.black, fontSize: 30),
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
                        'Edit your Last Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Container(
                    margin: const EdgeInsets.only(right: 88),
                    child: const Text(
                      'Enter your last name to consider your vote',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(height: 20),
                  TextFormField(
                    controller: last_name,
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
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Enter your last name",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  Container(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Save Changes'),
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

class Admin_ContactUpdate extends StatefulWidget {
  final Admins user;
  const Admin_ContactUpdate(this.user, {super.key});
  @override
  _ContactUpdate createState() => _ContactUpdate(user);
}

class _ContactUpdate extends State<Admin_ContactUpdate> {
  final Admins user;
  _ContactUpdate(this.user);
  String? _validateContact(value) {
    if (value!.isEmpty) {
      return 'Please enter a contact number';
    }
    RegExp contactRegExp = RegExp(r'^\d{4}-?\d{7}$');
    if (!contactRegExp.hasMatch(value)) {
      return 'Please enter a valid contact number';
    }
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String feedback = '';

  var e = TextEditingController();
  var p = TextEditingController();
  var c = TextEditingController();
  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var num = TextEditingController();

  final apiController apicontroller = apiController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      apicontroller.updatePhoneNoAdmin(user.Cnic, num.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
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
                          bottomRight: Radius.circular(21),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/images/positive-vote.png'),
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
                                text: 'Edit ',
                                style:
                                TextStyle(color: Colors.blue, fontSize: 30),
                              ),
                              TextSpan(
                                text: 'Profile ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
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
                          'Edit your Contact Number',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 5),
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const Text(
                        'Enter your active correct number to consider your vote',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: num,
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
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "Enter your phone number",
                      ),
                      validator: _validateContact,
                    ),
                    Container(height: 20),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Save Changes'),
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Admin_EmailUpdate extends StatefulWidget {
  final Admins user;
  const Admin_EmailUpdate(this.user, {super.key});
  @override
  _EmailUpdate createState() => _EmailUpdate(user);
}

class _EmailUpdate extends State<Admin_EmailUpdate> {
  final Admins user;
  _EmailUpdate(this.user);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  String feedback = '';

  var e = TextEditingController();
  var p = TextEditingController();
  var c = TextEditingController();
  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var num = TextEditingController();

  final apiController apicontroller = apiController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      apicontroller.updateEMailAdmin(user.Cnic, e.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
      ),
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
                        bottomRight: Radius.circular(21),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/positive-vote.png'),
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
                              text: 'Edit ',
                              style:
                              TextStyle(color: Colors.blue, fontSize: 30),
                            ),
                            TextSpan(
                              text: 'Profile ',
                              style:
                              TextStyle(color: Colors.black, fontSize: 30),
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
                        'Edit your Email Address',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  const Text(
                    'Enter your Correct E-mail Address in order to consider your vote',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Container(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: e,
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
                      prefixIcon: const Icon(Icons.add_card),
                      hintText: "Enter your Email",
                    ),
                    validator: _validateEmail,
                  ),
                  Container(height: 20),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Save Changes'),
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
