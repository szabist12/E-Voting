import 'dart:convert';

import 'package:app/Candidate_Profile/Candidate_UpdateFields.dart';
import 'package:app/Candidate_Profile/candidate_pp.dart';
import 'package:app/Candidates.dart';

import 'package:app/login_options.dart';
import 'package:flutter/material.dart';

import '../apiController.dart';

class candidate_ProfilePage extends StatefulWidget {
  final Candidates user;

  const candidate_ProfilePage(this.user, {super.key});

  @override
  State<candidate_ProfilePage> createState() => _candidate_ProfilePageState();
}

class _candidate_ProfilePageState extends State<candidate_ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Map<int, IconData> iconsLeading = {
      0: Icons.person_3_rounded,
      1: Icons.person_add_alt_sharp,
      2: Icons.credit_card,
      3: Icons.phone,
      4: Icons.email_outlined,
      // Add more cases as needed
    };
    String fname = widget.user.First_Name;
    String lname = widget.user.Last_Name;
    String cnic = widget.user.Cnic;
    String phone = widget.user.Phone_No;
    String email = widget.user.E_Mail;

    Map<int, Color> iconColors = {
      0: Colors.blueAccent,
      1: Colors.blueAccent,
      2: Colors.blueAccent,
      3: Colors.blueAccent,
      4: Colors.blueAccent,
      5: Colors.blueAccent,
      6: Colors.blueAccent,
      7: Colors.blueAccent,
      8: Colors.blueAccent,
    };
    var arrField = [
      'First Name',
      'Last Name',
      'CNIC Number',
      'Contact Number',
      'E-Mail'
    ];
    var arrNames = [fname, lname, cnic, phone, email];

    Map<int, IconData> iconMap = {
      0: Icons.edit,
      1: Icons.edit,
      2: Icons.lock,
      3: Icons.edit,
      4: Icons.edit,
      // Add more cases as needed
    };
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(
                      Icons.refresh), // Use Icon widget to represent the icon
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginOptionsPage()));
                  },
                  icon: const Icon(Icons
                      .logout_sharp), // Use Icon widget to represent the icon
                ),
              ],
            ),
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    FutureBuilder(
                      future: Apihelper.candidateimage(widget.user.Cnic, context),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data['img'].toString() == "null" ||
                              snapshot.data['img'].toString() == ""
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/avatar.jpg",
                              width: 100,
                              height: 100,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                                base64Decode(snapshot.data['img']),
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover),
                          );
                        } else if (snapshot.hasError) {
                          return const Icon(
                            Icons.error,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.person_add_alt_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Candidate_UploadProfileImage(
                                        candidates: widget.user,
                                      )),
                            );
                            // Handle edit button tap
                            // You can navigate to the edit profile screen or show a dialog here
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(height: 20),
            Text(
              '$fname $lname',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            Container(height: 5),
            Text(
              cnic,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
            Container(height: 20),
            SizedBox(
              width: 200, // Set your desired width
              height: 50, // Set your desired height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set your desired border radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Candidate_UploadProfileImage(
                          candidates: widget.user,
                        )),
                  );
                },
                child: const Text(
                  'Update Profile Picture',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15, // Set your desired font size
                  ),
                ),
              ),
            ),
            Container(height: 40),
            Container(
              margin: const EdgeInsets.only(
                  left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Personal ',
                            ),
                          ])),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: 'Information ',
                            )
                          ])),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      iconsLeading[index],
                      color: iconColors[index], // Applying color from the map
                    ),
                    title: Text(arrField[index]),
                    subtitle: Text(arrNames[index]),
                    trailing: GestureDetector(
                      onTap: () {
                        // Navigate to the appropriate edit page based on the index
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Candidate_FirstNamePage(widget.user)),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Candidate_LastNamePage(widget.user)),
                            );
                            break;
                          case 2:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //   ),
                          // );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Candidate_ContactUpdate(widget.user)),
                            );
                            break;
                          case 4:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Candidate_EmailUpdate(widget.user)),
                            );
                        }
                      },
                      child: Icon(iconMap[index]),
                    ),
                  );
                },
                itemCount: arrNames.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 20,
                    thickness: 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
