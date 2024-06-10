import 'dart:convert';

import 'package:app/apiController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CandidateUsers extends StatefulWidget {
  const CandidateUsers({super.key});

  @override
  _CandidateUsersState createState() => _CandidateUsersState();
}

class _CandidateUsersState extends State<CandidateUsers> {
  TextEditingController s = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                SizedBox(
                  height: 40,
                  width: 200,
                  child: TextField(
                    controller: s,
                    onChanged: (s){setState(() {});},
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon:
                        const Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none),
                        hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                        hintText: "Search users"),
                  ),
                ),
              ]),
              Row(
                children: [
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      // Handle menu item selection
                      switch (value) {
                        case 'Option 1':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Voter_users()),
                          );
                          break;
                      // case 'Option 2':
                      // // Navigator.pushReplacement(
                      // //   context,
                      // //   MaterialPageRoute(builder: (context) => SplashScreen()),
                      // // );
                      //   break;
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Option 1',
                        child: Text('Voters'),
                      ),
                      // PopupMenuItem<String>(
                      //   value: 'Option 2',
                      //   child: Text('Admins'),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: const Text(
                          'Candidates',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: apiController.getAllCandidates(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (s.text.isEmpty) {
                        return userComponent(user: snapshot.data[index]);
                      } else {
                        if ((snapshot.data[index]['Cnic'])
                            .toString()
                            .toLowerCase()
                            .contains(s.text.toLowerCase())) {
                          return userComponent(user: snapshot.data[index]);
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  userComponent({required Map user}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            user['img'].toString() == "null"
                ? const SizedBox.shrink()
                : SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(base64Decode(user['img'])),
                )),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user['First_Name'],
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(user['Cnic'], style: TextStyle(color: Colors.grey[500])),
            ])
          ]),
          GestureDetector(
            onTap: () async {
              bool cc = await Apihelper.deletecandiate(user['Cnic'], context);
              if (cc) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Candidate Deleted'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Try again later'),
                  ),
                );
              }
              setState(() {});
            },
            child: AnimatedContainer(
                height: 35,
                width: 110,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                    child:
                    Text('Delete', style: TextStyle(color: Colors.white)))),
          )
        ],
      ),
    );
  }
}

class Voter_users extends StatefulWidget {
  const Voter_users({Key? key}) : super(key: key);

  @override
  _VoterPageState createState() => _VoterPageState();
}

class _VoterPageState extends State<Voter_users> {
  TextEditingController s = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(children: [
            SizedBox(
              height: 38,
              child: TextField(
                controller: s,
                style: const TextStyle(color: Colors.black),
                onChanged: (s){setState(() {});},
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintStyle:
                    const TextStyle(fontSize: 14, color: Colors.black),
                    hintText: "Search users"),
              ),
            ),
          ]),
          actions: [
            Row(
              children: [
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    // Handle menu item selection
                    switch (value) {
                      case 'Option 1':
                        Navigator.pop(context);
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const CandidateUsers()),
                        // );
                        break;
                    // case 'Option 2':
                    // // Navigator.pushReplacement(
                    // //   context,
                    // //   MaterialPageRoute(builder: (context) => SplashScreen()),
                    // // );
                    //   break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Option 1',
                      child: Text('Candidates'),
                    ),
                    // PopupMenuItem<String>(
                    //   value: 'Option 2',
                    //   child: Text('Admins'),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: const Text(
                        'Voters',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                ),
              ],
            ),
          ],
        ),
        body: FutureBuilder(
          future: apiController.getAllVoters(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index]);
                  if (s.text.isEmpty) {
                    return userComponent(user: snapshot.data[index]);
                  } else {
                    if ((snapshot.data[index]['Cnic'])
                        .toString()
                        .toLowerCase()
                        .contains(s.text.toLowerCase())) {
                      return userComponent(user: snapshot.data[index]);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                },
              );
            } else if (snapshot.hasError) {
              return const Icon(Icons.error);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  userComponent({required Map user}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            user['img'].toString() == "null"
                ? const SizedBox.shrink()
                : SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(base64Decode(user['img'])),
                )),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user['First_Name'],
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(user['Cnic'], style: TextStyle(color: Colors.grey[500])),
            ])
          ]),
          GestureDetector(
            onTap: () async {
              bool cc = await Apihelper.deletevoter(user['Cnic'], context);
              if (cc) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Voter Deleted'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Try again later'),
                  ),
                );
              }
              setState(() {});
            },
            child: AnimatedContainer(
                height: 35,
                width: 110,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                    child:
                    Text('Delete', style: TextStyle(color: Colors.white)))),
          )
        ],
      ),
    );
  }
}
