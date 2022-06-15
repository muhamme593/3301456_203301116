import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Database/CourseData.dart';
import 'package:sampleproject/screen/detailsScreen.dart';

class favoriteScreen extends StatefulWidget {
  var idKey;
  favoriteScreen({required this.idKey});
  @override
  State<favoriteScreen> createState() => _favoriteScreenState();
}

class _favoriteScreenState extends State<favoriteScreen> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          title: Text('Favorite'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/newAccount/${widget.idKey}/items')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Transform.translate(
                  offset: Offset(0, -130),
                  child: Text(
                    'No Items',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }
            var newItem = [];
            var s2 = snapshot.data!.docs;

            for (int i = 0; i < s2.length; i++) {
              if (s2[i]['id'] != '') {
                newItem.add(s2[i]['id']);
              }
            }
            print('========== ${newItem}');
            return ListView.builder(
              itemCount: newItem.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: detailsScreen(
                            index: CourseData[int.parse(newItem[index])]['id'],
                            idKey: widget.idKey,
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(
                                      CourseData[int.parse(newItem[index])]
                                          ['imageUrl'],
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            '${CourseData[int.parse(newItem[index])]['courseName']} programing Language',
                                            style: GoogleFonts.oswald(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 180,
                                          child: Text(
                                            '${CourseData[int.parse(newItem[index])]['title'].toString().substring(0, 50)} .... ',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}
