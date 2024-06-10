import 'dart:math';

import 'package:app/Voter_Profile/otpchecking.dart';
import 'package:flutter/material.dart';

import '../Voters.dart';
import '../apiController.dart';
import '../strings.dart';

class voterelectiondetails extends StatefulWidget {
  voterelectiondetails(
      {super.key,
        required this.user,
        required this.data,
        required this.electionid});
  String electionid;
  final Voters user;
  List data;

  @override
  State<voterelectiondetails> createState() => _voterelectiondetailsState();
}

class _voterelectiondetailsState extends State<voterelectiondetails> {
  String partyff = "PTI";
  String naff = "NA-134";
  String ppff = "PP-134";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cast your vote",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: partyff,
                      onChanged: (String? newValue) {
                        setState(() {
                          partyff = newValue!;
                        });
                      },
                      items:
                      party.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: naff,
                      onChanged: (String? newValue) {
                        setState(() {
                          naff = newValue!;
                        });
                      },
                      items: na.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: ppff,
                      onChanged: (String? newValue) {
                        setState(() {
                          ppff = newValue!;
                        });
                      },
                      items: pp.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: widget.data.map((e) {
                  return e['status'] == 'old'
                      ? filters(e)
                      : const SizedBox.shrink();
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filters(dynamic e) {
    if (e['na'] == naff) {
      if (e['pp'] == ppff) {
        if (e['party'] == partyff) {
          return listdata(e);
        } else {
          return const SizedBox.shrink();
        }
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget listdata(dynamic e) {
    return InkWell(
      onTap: () async {
        final random = Random();
        final randomNumber = random.nextInt(999999 - 100000) + 100000;
        bool c = await Apihelper.sendotp(
            randomNumber.toString().substring(0, 3),
            randomNumber.toString().substring(3, 6),
            widget.user.E_Mail,
            widget.user.Phone_No,
            context);
        if (c) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => otpchecking(
                    electionid: widget.electionid,
                    candidateid: e['uid'],
                    userid: widget.user.Id_,
                    otp: randomNumber.toString(),
                  )));
        } else {
          const snackBar = SnackBar(
            content: Text('Failed to send OTP'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: Apihelper.findcandidatebyid(e['uid'], context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.memory(
                            stringtoimg(snapshot.data['img']),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          const Text("Name"),
                          Text(
                            "${snapshot.data['First_Name']} ${snapshot.data['Last_Name']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "NA : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      e['na'],
                      style: const TextStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "PP : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      e['pp'],
                      style: const TextStyle(),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      stringtoimg(e['image']),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Area",
                        ),
                        Text(
                          e['area'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Status",
                        ),
                        Text(
                          e['status'] == "old" ? "Approved" : "Pending",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
