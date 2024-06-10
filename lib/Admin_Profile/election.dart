import 'package:app/strings.dart';
import 'package:flutter/material.dart';

import '../apiController.dart';
import '../leaderboard.dart';

class Elections extends StatefulWidget {
  const Elections({super.key});

  @override
  State<Elections> createState() => _ElectionsState();
}

class _ElectionsState extends State<Elections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "All Created Elections",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Dialog(
                              child: CreatingElection(),
                            );
                          });
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
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
                  Expanded(
                      child: Text(
                        "Action",
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
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: aspectcandiadte(
                                        data: snapshot.data[index]['users'],
                                        electionid: snapshot.data[index]['_id'],
                                      ),
                                    );
                                  });
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.2)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                        snapshot.data[index]['type'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      child: Text(
                                          snapshot.data[index]['startdate'])),
                                  Expanded(
                                      child: Text(
                                          snapshot.data[index]['enddate'])),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            List<Map<String, dynamic>> c =
                                            List<Map<String, dynamic>>.from(
                                                snapshot.data[index]
                                                ['users']);
                                            c = c
                                                .where((element) =>
                                            element['status'] == 'old')
                                                .toList();
                                            c.sort((a, b) =>
                                                b['vote'].compareTo(a['vote']));
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        leaderboard(
                                                          data: c,
                                                        )));
                                          },
                                          child:
                                          const Icon(Icons.leaderboard))),
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

class CreatingElection extends StatefulWidget {
  const CreatingElection({super.key});

  @override
  State<CreatingElection> createState() => _CreatingElectionState();
}

class _CreatingElectionState extends State<CreatingElection> {
  String type = 'local body';
  String startdate = '';
  String enddate = '';

  List<String> types = ['local body', 'national body'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Create Election",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            value: type,
            onChanged: (newValue) =>
            {type = newValue.toString(), setState(() {})},
            items: types.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          InkWell(
              onTap: () async {
                final DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                );
                if (pickeddate != null) {
                  setState(() {
                    startdate = pickeddate.toString().substring(0, 10);
                  });
                }
              },
              child: Text(startdate == "" ? "Select Start Date" : startdate)),
          InkWell(
              onTap: () async {
                final DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                );
                if (pickeddate != null) {
                  setState(() {
                    enddate = pickeddate.toString().substring(0, 10);
                  });
                }
              },
              child: Text(enddate == "" ? "Select End Date" : enddate)),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (startdate == "" || enddate == "") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please Select Date"),
                ));
              } else if (startdate == enddate) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Start Date and End Date cannot be same"),
                ));
              } else if (DateTime.parse(startdate)
                  .isAfter(DateTime.parse(enddate))) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Start Date cannot be greater than End Date"),
                ));
              } else {
                bool status = await Apihelper.registration(
                    type, startdate, enddate, context);
                if (status) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Election Created Successfully"),
                  ));
                  Navigator.pop(context);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Create",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class aspectcandiadte extends StatefulWidget {
  aspectcandiadte({super.key, required this.data, required this.electionid});
  List data;
  String electionid;

  @override
  State<aspectcandiadte> createState() => _aspectcandiadteState();
}

class _aspectcandiadteState extends State<aspectcandiadte> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.blue),
            child: const Row(
              children: [
                Expanded(
                    child: Text(
                      "User",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: widget.data.map((e) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[50],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future:
                        Apihelper.findcandidatebyid(e['uid'], context),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
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
                                    e['status'] == "old" ? "Approved" : e['status']
                                        == "new" ? "Pending" : e['status'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      e['status'] == 'new'?
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              List d = widget.data;
                              for (var element in d) {
                                if (element['uid'] == e['uid']) {
                                  element['status'] = 'old';
                                }
                              }
                              bool cc = await Apihelper.updatestatuslist(
                                  widget.electionid, d, context);
                              if (cc) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                    "Updated",
                                  ),
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                    "Not Updated",
                                  ),
                                ));
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: const EdgeInsetsDirectional.all(5),
                              margin: const EdgeInsetsDirectional.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: const Center(child: Text("Aspect",style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              List d = widget.data;
                              for (var element in d) {
                                if (element['uid'] == e['uid']) {
                                  element['status'] = 'rejected';
                                }
                              }
                              bool cc = await Apihelper.updatestatuslist(
                                  widget.electionid, d, context);
                              if (cc) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                    "Updated",
                                  ),
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                    "Not Updated",
                                  ),
                                ));
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: const EdgeInsetsDirectional.all(5),
                              margin: const EdgeInsetsDirectional.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: const Center(child: Text("Reject",style: TextStyle(color: Colors.white),)),
                            ),
                          )
                        ],
                      )
                          : const SizedBox.shrink()
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
