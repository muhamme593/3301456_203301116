

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/Database/CourseData.dart';

class detailsScreen extends StatefulWidget {
  int index;
  var idKey;
  detailsScreen({required this.index, required this.idKey});
  @override
  State<detailsScreen> createState() => _detailsScreenState();
}

class _detailsScreenState extends State<detailsScreen> {
  bool isClisk = false;
  getStar(bool index) {
    return Icon(
      Icons.star,
      color: index == true ? Colors.orange : Colors.black,
    );
  }

  List<Widget> star(int index) {
    List<Widget> ctx = [];
    for (int i = 0; i < 5; i++) {
      if (index > i) {
        ctx.add(getStar(true));
      } else {
        ctx.add(getStar(false));
      }
    }
    return ctx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/newAccount/${widget.idKey}/items/')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DocumentSnapshot> s1 = snapshot.data!.docs;

            return SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 220,
                          color: Colors.grey[400],
                          child: Image.asset(
                            CourseData[widget.index]['imageUrl'],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Learn ${CourseData[widget.index]['courseName']} Programming Now',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /////
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children:
                              star(CourseData[widget.index]['starNumber']),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 350,
                          child: Text(
                            '${CourseData[widget.index]['title']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 320,
                          child: Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ),
                        ExpansionTile(
                          iconColor: Colors.black,
                          title: Text(
                            'Details',
                            style: GoogleFonts.oswald(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 20),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Videos',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Average video duration',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'date of registration',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 120,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '24',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        '25.0 minute',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        '2021-04-20',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${CourseData[widget.index]['price']} TRY',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    if (s1[widget.index]['id'] !=
                                        widget.index.toString()) {
                                      FirebaseFirestore.instance
                                          .collection('newAccount')
                                          .doc('${widget.idKey}')
                                          .collection('items')
                                          .doc('${widget.index}')
                                          .set({'id': '${widget.index}'});
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('newAccount')
                                          .doc('${widget.idKey}')
                                          .collection('items')
                                          .doc('${widget.index}')
                                          .set({'id': ''});
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 40,
                                  color: s1[widget.index]['id'] ==
                                          widget.index.toString()
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AnimatedOpacity(
                                opacity: (s1[widget.index] as dynamic)['id'] ==
                                        widget.index.toString()
                                    ? 0
                                    : 1,
                                duration: Duration(milliseconds: 300),
                                child: Text('Add to favorite'),
                              ),
                              Transform.translate(
                                offset: Offset(0, -15),
                                child: AnimatedOpacity(
                                  opacity:
                                      (s1[widget.index] as dynamic)['id'] ==
                                              widget.index.toString()
                                          ? 1
                                          : 0,
                                  duration: Duration(milliseconds: 300),
                                  child: Text('Added'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
