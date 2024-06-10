import 'package:app/Admin_Profile/admin_profile.dart';
import 'package:app/Admin_Profile/election.dart';
import 'package:app/Admin_users/Admin_users.dart';
import 'package:flutter/material.dart';

import '../Admins.dart';

class Admin_Home extends StatefulWidget {
  final Admins admins;

  const Admin_Home(this.admins, {super.key});

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  int _selectedIndex = 0;
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle_sharp),
      label: 'User',
    ),
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
        return const CandidateUsers();
      case 1:
        return const Elections();
      case 2:
        return admin_ProfilePage(widget.admins);
      default:
        return Container();
    }
  }

}
