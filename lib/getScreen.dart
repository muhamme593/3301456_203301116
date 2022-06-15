import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/screen/drawerScreen.dart';
import 'package:sampleproject/screen/homePgeScreen.dart';
import 'package:sampleproject/screen/myProfileScreen.dart';
import 'package:sampleproject/screen/techNewsScreen.dart';

class getScreen extends StatefulWidget {
  var idKey;
  getScreen({required this.idKey});
  @override
  State<getScreen> createState() => _getScreenState();
}

class _getScreenState extends State<getScreen> {
  int next = 0;

  /// ل تحديد الصفحة الرئيسية عند فتح الصغحة
  void _nextPage(int index) {
    setState(() {
      next = index; // من اجل زيادة عندما يتم التغيير
    });
  }

  List<Widget> getBodyInf = [];
  @override
  void initState() {
    getBodyInf = [
      homePageScreen(idKey: widget.idKey),
      techNewsScreen(),
      myProfileScreen(idKey: widget.idKey),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.red,
        child: drawerScreen(idKey: widget.idKey),
      ),
      body: getBodyInf[next],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home Page',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.home),
            ),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            label: 'News',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(FontAwesomeIcons.newspaper),
            ),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(FontAwesomeIcons.user),
            ),
            backgroundColor: Colors.red,
          ),
        ],
        onTap: _nextPage,
        currentIndex: next,
        selectedLabelStyle:
            GoogleFonts.oswald(fontSize: 18, color: Colors.white),
        unselectedIconTheme: IconThemeData(size: 20),
        selectedIconTheme: IconThemeData(size: 25),

        ///  هنا ال INDEX الخاص ب كل صفحة
        showUnselectedLabels: false,
        selectedFontSize: 20,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
