// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/ui/screens/home_screen.dart';
import 'package:project/ui/screens/counter_screen.dart';

class NavButton extends StatefulWidget {
  const NavButton({super.key});

  @override
  State<NavButton> createState() => _NavButtonState();
}

int currentIndex = 0;
List<Widget> screen = [
  HomeScreen(),
  CounterScreen(
    title: 'Counter Screen',
  )
];

class _NavButtonState extends State<NavButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Color.fromARGB(255, 210, 210, 210),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.plus_one_outlined), label: 'Counter'),
          ]),
    );
  }
}
