import 'package:app/apiController.dart';
import 'package:app/strings.dart';
import 'package:flutter/material.dart';

class leaderboard extends StatefulWidget {
  leaderboard({super.key, required this.data});
  List data;

  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
  List top = [];
  List bottom = [];

  void first(List data) {
    top.clear();
    bottom.clear();
    for (int i = 0; i < data.length; i++) {
      if (i == 0 || i == 1 || i == 2) {
        top.add(data[i]);
      } else {
        bottom.add(data[i]);
      }
    }
    if (top.length == 1) {
      top.add({});
      top.add({});
    } else if (top.length == 2) {
      top.add({});
    }
  }

  @override
  void initState() {
    first(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(child: aa()),
    );
  }

  Widget aa() {
    if (widget.data.isNotEmpty) {
      if (bottom.isNotEmpty) {
        return ListView.builder(
          itemCount: bottom.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  topstack(context),
                  listview(context, bottom[index], index)
                ],
              );
            } else {
              return listview(context, bottom[index], index);
            }
          },
        );
      } else {
        return topstack(context);
      }
    } else {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: const Text("Leader Board"),
          ),
          const Text("No Data Avaliable"),
        ],
      );
    }
  }

  Widget topstack(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.03,
            child: Image.asset(
              'assets/leaderboard.jpg',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.07],
                    colors: [Colors.white, Colors.white.withOpacity(0.0)])),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                toplistview(context, 1, 0.28),
                toplistview(context, 0, 0.35),
                toplistview(context, 2, 0.28)
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.13,
            left: MediaQuery.of(context).size.width * 0.1,
            child: star(context),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.44,
            child: star(context),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.13,
            right: MediaQuery.of(context).size.width * 0.1,
            child: star(context),
          ),
        ],
      ),
    );
  }

  Widget star(BuildContext context) {
    return Image.asset(
      'assets/star.jpg',
      width: MediaQuery.of(context).size.width * 0.12,
    );
  }

  Widget toplistview(BuildContext context, int index, double height) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3333,
      height: MediaQuery.of(context).size.height * height,
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: top[index].toString() != '{}'
          ? Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            top[index]["vote"].toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
              future:
              Apihelper.findcandidatebyid(top[index]['uid'], context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding:
                        const EdgeInsets.only(bottom: 3, left: 2),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.memory(
                              stringtoimg(snapshot.data['img']),
                              width:
                              MediaQuery.of(context).size.width * 0.1,
                              fit: BoxFit.cover,
                              height:
                              MediaQuery.of(context).size.width * 0.1,
                            )),
                      ),
                      Text(
                        snapshot.data['First_Name'] +
                            " " +
                            snapshot.data['Last_Name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error_outline);
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.memory(
                stringtoimg(top[index]["image"]),
                width: MediaQuery.of(context).size.width * 0.1,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width * 0.1,
              )),
          Text(
            top[index]["party"].toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            top[index]["na"].toString(),
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            top[index]["pp"].toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      )
          : const SizedBox.shrink(),
    );
  }

  Widget listview(BuildContext context, Map data, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Divider(
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.memory(
                    stringtoimg(bottom[index]["image"]),
                    width: MediaQuery.of(context).size.width * 0.1,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * 0.1,
                  )),
              FutureBuilder(
                  future: Apihelper.findcandidatebyid(
                      bottom[index]['uid'], context),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.only(bottom: 3, left: 2),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.memory(
                                  stringtoimg(snapshot.data['img']),
                                  width:
                                  MediaQuery.of(context).size.width * 0.1,
                                  fit: BoxFit.cover,
                                  height:
                                  MediaQuery.of(context).size.width * 0.1,
                                )),
                          ),
                          Text(
                            snapshot.data['First_Name'] +
                                " " +
                                snapshot.data['Last_Name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error_outline);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              Text(
                bottom[index]["vote"].toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bottom[index]["party"].toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    bottom[index]["na"].toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    bottom[index]["pp"].toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
