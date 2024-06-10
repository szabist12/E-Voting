import 'package:app/Candidate_Profile/candidate_profile.dart';
import 'package:app/Candidate_Profile/candidateelection.dart';
import 'package:app/Candidates.dart';
import 'package:flutter/material.dart';

class Candidate_Home extends StatefulWidget {
  final Candidates candidates;

  const Candidate_Home(this.candidates, {super.key});

  @override
  State<Candidate_Home> createState() => _Candidate_HomeState();
}

class _Candidate_HomeState extends State<Candidate_Home> {

  int _selectedIndex = 0;
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.design_services),
      label: 'Elections',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _items,
      ),
      body: SafeArea(child: bodyContainer(context)),
    );
  }

  Widget bodyContainer(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return candidateelection(user:widget.candidates);
      case 1:
        return candidate_ProfilePage(widget.candidates);
      default:
        return Container();
    }
  }
}
