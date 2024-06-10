import 'package:app/Voter_Profile/Profile.dart';
import 'package:app/Voter_Profile/voterelection.dart';
import 'package:app/Voters.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final Voters person;

  const NextPage(this.person, {super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          backgroundColor: Colors.white60,
          color: Colors.blueAccent,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => _onItemTapped(index),
          items: const [
            Icon(
              Icons.design_services,
              color: Colors.white,
            ),
            Icon(Icons.account_circle, color: Colors.white),
          ],
        ),
        body: SafeArea(child: bodyContainer(context)));
  }

  Widget bodyContainer(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return voterelection(
          user: widget.person,
        );
      case 1:
        return ProfilePage(widget.person);
      default:
        return Container();
    }
  }
}
