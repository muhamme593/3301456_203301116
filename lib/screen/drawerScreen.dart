import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/getScreen.dart';
import 'package:sampleproject/screen/authScreen.dart';
import 'package:sampleproject/screen/favoriteScree.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawerScreen extends StatefulWidget {
  var idKey;
  drawerScreen({required this.idKey});
  @override
  State<drawerScreen> createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          ///
          ////
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('/newAccount/${widget.idKey}/user')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DocumentSnapshot> s1 = snapshot.data!.docs;

              return !s1.isEmpty
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: (() {}),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      height: 110,
                                      width: 110,
                                      fit: BoxFit.cover,
                                      imageUrl: (s1[0] as dynamic)['image_url'],
                                      placeholder: (context, url) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AnimatedOpacity(
                                              duration: Duration.zero,
                                              opacity: .5,
                                              child: Image.asset(
                                                  'images/udemy.png')),
                                          CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${(s1[0] as dynamic)['userName']}',
                                  style: GoogleFonts.breeSerif(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${(s1[0] as dynamic)['email']}',
                                  style: GoogleFonts.breeSerif(
                                    fontSize: 20,
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text('');
            },
          ),
          SizedBox(
            width: 250,
            child: Divider(
              color: Colors.white,
              thickness: 1.2,
            ),
          ),
          getCardInf(context, 'Home Page', Icons.home, () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: getScreen(
                  idKey: widget.idKey,
                ),
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
              ),
            );
          }),
          SizedBox(
            height: 5,
          ),
          getCardInf(context, 'Favorite', Icons.favorite, () {
            Navigator.push(
              context,
              PageTransition(
                child: favoriteScreen(idKey: widget.idKey),
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
              ),
            );
          }),
          SizedBox(
            height: 5,
          ),
          getCardInf(context, 'Sign out', Icons.logout, () async {
            SharedPreferences s1 = await SharedPreferences.getInstance();
            s1.setBool('fetch', false);
            s1.setString('key', '');
            Navigator.push(
              context,
              PageTransition(
                child: authScreen(
                  authMode: AuthMode.Login,
                ),
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 500),
              ),
            );
          }),
        ],
      ),
    );
  }
}

Widget getCardInf(
    BuildContext context, String label, IconData icon, void addFunc()) {
  return InkWell(
    onTap: (() {
      addFunc();
    }),
    child: Card(
      color: Colors.white,
      child: ListTile(
        leading: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    ),
  );
}
