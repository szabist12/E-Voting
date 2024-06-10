import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Candidates.dart';
import '../apiController.dart';
import '../leaderboard.dart';
import '../strings.dart';

class candidateelection extends StatefulWidget {
  const candidateelection({super.key,required this.user});
  final Candidates user;

  @override
  State<candidateelection> createState() => _candidateelectionState();
}

class _candidateelectionState extends State<candidateelection> {
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
                              List l = List.of(snapshot.data[index]['users']);
                              bool t = false;
                              Map d = {};
                              if (l.isEmpty){
                                t = false;
                              } else {
                                for (var element in l) {
                                  if (element['uid'] == widget.user.Id_) {
                                    d = element;
                                    t = true;
                                  } else {
                                    t = false;
                                  }
                                }
                              }
                              if(t == false || d['status'] == 'rejected'){
                                // print(snapshot.data[index]['_id']);
                                // print(widget.user);
                                // print(snapshot.data[index]['_id']);
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: registercandidate(
                                          electionid: snapshot.data[index]['_id'],
                                          user: widget.user,
                                          data: List.of(snapshot.data[index]['users']),
                                          status:d.isEmpty?"":d['status']
                                        ),
                                      );
                                    });
                                setState(() {});
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Already Registered"),
                                ));
                              }
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
                                          child: Text(
                                              snapshot.data[index]['startdate'])),
                                      Expanded(
                                          child: Text(
                                              snapshot.data[index]['enddate'])),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Status : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(statusdata(snapshot.data[index]['users']))
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            DateTime parsedDate = DateTime.parse(snapshot.data[index]['enddate']);
                                            DateTime currentDate = DateTime.now();
                                            int comparison = currentDate.compareTo(parsedDate);
                                            if (comparison > 0 ) {
                                              List<Map<String, dynamic>> c = List<Map<String, dynamic>>.from(snapshot.data[index]['users']);
                                              c = c.where((element) => element['status'] == 'old').toList();
                                              c.sort((a, b) => b['vote'].compareTo(a['vote']));
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      leaderboard(data: c,)));
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Wait till election ended"),
                                                ),
                                              );
                                            }
                                          },
                                          child: const Icon(Icons.leaderboard_outlined))
                                    ],
                                  )
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

  String statusdata(List data){
    if(data.isEmpty){
      return "Not Applied";
    } else {
      String c = "Not Applied";
      for (var element in data) {
        if(element['uid'] == widget.user.Id_ && element['status'] == 'new'){
          c = "Applied";
          break;
        } else if(element['uid'] == widget.user.Id_ && element['status'] == 'rejected'){
          c = "Rejected";
          break;
        } else if(element['uid'] == widget.user.Id_ && element['status'] == 'old'){
          c = "Approved";
          break;
        }
      }
      return c;
    }
  }
}

class registercandidate extends StatefulWidget {
  registercandidate({super.key, required this.electionid,
    required this.user, required this.data, required this.status});
  String electionid,status;
  final Candidates user;
  List data;

  @override
  State<registercandidate> createState() => _registercandidateState();
}

class _registercandidateState extends State<registercandidate> {
  TextEditingController areaname = TextEditingController();
  String partyff = "PTI";
  String naff = "NA-134";
  String ppff = "PP-134";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text(
            "Register Election",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Party : ",style: TextStyle(fontWeight: FontWeight.bold),),
              DropdownButton<String>(
                value: partyff,
                onChanged: (String? newValue) {
                  setState(() {
                    partyff = newValue!;
                  });
                },
                items: party.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("NA : ",style: TextStyle(fontWeight: FontWeight.bold),),
              DropdownButton<String>(
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("PP : ",style: TextStyle(fontWeight: FontWeight.bold),),
              DropdownButton<String>(
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("intahabi nishan : ",style: TextStyle(fontWeight: FontWeight.bold),),
              img != null ? InkWell(
                onTap: ()=>getImageFromGallery(),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: (kIsWeb ? Image.network(img!.path  ,width: 50,height: 50,) :
                    Image.file(img!, width: 50, height: 50, fit: BoxFit.cover))),
              ) :
              InkWell(
                onTap: ()=>getImageFromGallery(),
                child: const Icon(Icons.add),
              )
            ],
          ),
          const SizedBox(height: 20,),
          TextFormField(
              controller: areaname,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide:
                    const BorderSide(color: Colors.black45, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: const BorderSide(
                      color: Colors.green,
                    )),
                prefixIcon: const Icon(Icons.add_card),
                hintText: "Enter your Area Name",
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                if (areaname.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Enter Area Name",
                    ),
                  ));
                } else if (statusdata(widget.data)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Already register",),));
                } else if (img == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Add image",),));
                } else {
                  String imgg = await imgfromfile(imgx!);
                  if (widget.status == 'rejected') {
                    await Apihelper.deletecandidatetoelection(widget.electionid, widget.user.Id_, context);
                  }
                  bool data = await Apihelper.registercandidatetoelection(widget.electionid,
                      {"image":imgg,"party":partyff, "na":naff, "pp":ppff,'vote':0,
                        "area": areaname.text, "uid": widget.user.Id_, "status":"new"}, context);
                  if (data) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Register",),));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed",),));
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                "Register",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
        ],
      ),
    );
  }

  bool statusdata(List data){
    if(data.isEmpty){
      return false;
    } else {
      bool c = false;
      for (var element in data) {
        if(element['id'] == widget.user.Id_){
          c = true;
          break;
        }
      }
      return c;
    }
  }

  File? img;
  XFile? imgx;
  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      img = File(pickedFile.path);
      imgx = pickedFile;
      setState(() {});
    }
  }

}
