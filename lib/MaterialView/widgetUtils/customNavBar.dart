import 'package:firebasetest/MaterialView/Views/pollView.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar(
      {Key? key, required this.selectedIndex, required this.onClicked})
      : super(key: key);
  final selectedIndex;
  final Function onClicked;
  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  Widget get gnavbar {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            color: Colors.white,
            gap: 6,
            padding: EdgeInsets.all(15),
            onTabChange: (int index) {
              widget.onClicked(index);
            },
            tabs: const [
              GButton(
                icon: Icons.calendar_month,
                text: "KALENDER",
              ),
              // GButton(
              //   icon: Icons.poll,
              //   text: "ABSTIMMUNGEN",
              // ),
              GButton(
                icon: Icons.view_agenda,
                text: "MITGLIEDER",
              ),
              GButton(
                icon: Icons.view_array,
                text: "ÄMTER",
              ),
            ],
            selectedIndex: widget.selectedIndex,
          ),
        ),
      ),
    );
  }

  Widget get standardBottomNavbar {
    return NavigationBar(
      elevation: 5,
      destinations: [
        NavigationDestination(icon: Icon(Icons.telegram), label: "label"),
        NavigationDestination(icon: Icon(Icons.ad_units), label: "dawda")
      ],
    );
  }

  Widget get bottomNav {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          elevation: 5,
          enableFeedback: true,
          onTap: (value) => widget.onClicked(value),
          fixedColor: Colors.white,
          unselectedItemColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "KALENDER",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.poll),
              label: "ABSTIMMUNGEN",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              label: "MITGLIEDER",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_array),
              label: "ÄMTER",
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return gnavbar;
  }
}
