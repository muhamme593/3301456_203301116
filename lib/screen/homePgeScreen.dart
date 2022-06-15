import 'package:flutter/material.dart';
import 'package:sampleproject/Database/CourseData.dart';
import 'package:sampleproject/extra/newContainer.dart';
import 'package:sampleproject/extra/newContainer2.dart';


class homePageScreen extends StatelessWidget {
  var idKey;
  homePageScreen({required this.idKey});
  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            expandedHeight: 252,
            flexibleSpace: LayoutBuilder(
              builder: ((context, constraints) {
                ////
                ///
                top = constraints.biggest.height;
                print(constraints.maxHeight);

                return FlexibleSpaceBar(
                  title: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: top < 130 ? 1 : 0,
                    child: Text('Home Page'),
                  ),
                  centerTitle: true,
                  background: Container(
                    color: Colors.white,
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 310,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Opacity(
                                opacity: .5,
                                child: Image.asset(
                                  'images/background.jpg',
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(-20, -40),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: 300,
                                  child: Text(
                                    'A world of learning with udemy',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(110, 20),
                        child: Text(
                          'Top courses',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: SizedBox(
                          height: 250,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              newContainer(
                                imageUrl: CourseData[0]['imageUrl'],
                                starNumber: CourseData[0]['starNumber'],
                                title: CourseData[0]['title'],
                                index: CourseData[0]['id'],
                                idKey: idKey,
                              ),
                              newContainer(
                                imageUrl: CourseData[1]['imageUrl'],
                                starNumber: CourseData[1]['starNumber'],
                                title: CourseData[1]['title'],
                                index: CourseData[1]['id'],
                                idKey: idKey,
                              ),
                              newContainer(
                                imageUrl: CourseData[2]['imageUrl'],
                                starNumber: CourseData[2]['starNumber'],
                                title: CourseData[2]['title'],
                                index: CourseData[2]['id'],
                                idKey: idKey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(110, 0),
                        child: Text(
                          'Basic courses',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      newContainer2(
                        imageUrl: CourseData[3]['imageUrl'],
                        starNumber: CourseData[3]['starNumber'],
                        title: CourseData[3]['title'],
                        index: CourseData[3]['id'],
                        idKey: idKey,
                      ),
                      newContainer2(
                        imageUrl: CourseData[4]['imageUrl'],
                        starNumber: CourseData[4]['starNumber'],
                        title: CourseData[4]['title'],
                        index: CourseData[4]['id'],
                        idKey: idKey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
