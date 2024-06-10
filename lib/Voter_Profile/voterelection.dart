import 'package:app/Voter_Profile/voterelectiondetails.dart';
import 'package:app/leaderboard.dart';
import 'package:flutter/material.dart';

import '../Voters.dart';
import '../apiController.dart';

class voterelection extends StatefulWidget {
  const voterelection({super.key, required this.user});
  final Voters user;

  @override
  State<voterelection> createState() => _voterelectionState();
}

class _voterelectionState extends State<voterelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "All Created Elections",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                        "Election Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  Expanded(
                      child: Text(
                        "Start Date",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      child: Text(
                        "End Date",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Apihelper.getallelction(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.toString() == '[]') {
                      return const Center(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              List l = List.of(snapshot.data[index]['voters']);
                              bool t = false;
                              for (var element in l) {
                                element == widget.user.Id_
                                    ? t = true
                                    : t = false;
                              }
                              if (t) {
                                DateTime parsedDate = DateTime.parse(snapshot.data[index]['enddate']);
                                DateTime currentDate = DateTime.now();
                                int comparison = currentDate.compareTo(parsedDate);
                                if (comparison > 0 ) {
                                  // List<Map<String, dynamic>> c = List<Map<String, dynamic>>.from(snapshot.data[index]['users']);
                                  // c = c.where((element) => element['status'] == 'old').toList();
                                  // c.sort((a, b) => b['vote'].compareTo(a['vote']));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         leaderboard(data: c,)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Wait till election ended"),
                                    ),
                                  );
                                }
                              } else {
                                await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        voterelectiondetails(
                                          electionid: snapshot.data[index]
                                          ['_id'],
                                          user: widget.user,
                                          data: snapshot.data[index]['users'],
                                        )));
                                setState(() {});
                              }
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.2)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            snapshot.data[index]['type'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Expanded(
                                          child: Text(snapshot.data[index]
                                          ['startdate'])),
                                      Expanded(
                                          child: Text(
                                              snapshot.data[index]['enddate'])),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: Colors.black,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
