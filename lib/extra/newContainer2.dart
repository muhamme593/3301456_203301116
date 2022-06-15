import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/screen/detailsScreen.dart';

class newContainer2 extends StatefulWidget {
  String imageUrl;
  String title;
  int starNumber;
  int index;
  var idKey;

  newContainer2({
    required this.imageUrl,
    required this.starNumber,
    required this.title,
    required this.idKey,
    required this.index,
  });
  @override
  State<newContainer2> createState() => _newContainer2State();
}

class _newContainer2State extends State<newContainer2> {
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
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          PageTransition(
            child: detailsScreen(
              index: widget.index,
              idKey: widget.idKey,
            ),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
          ),
        );
      }),
      child: Container(
        height: 240,
        width: 500,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 150,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(widget.imageUrl))), ///// IMAGE
            ),
            Transform.translate(
              offset: Offset(0, -10),
              child: Container(
                width: 300,
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Text(
                      '${widget.title.substring(0, 60)} ... ',

                      /// TITLE
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: star(widget.starNumber),

                          /// STARS
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
