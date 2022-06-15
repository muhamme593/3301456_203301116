import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/screen/detailsScreen.dart';

class newContainer extends StatefulWidget {
  String imageUrl;
  String title;
  int starNumber;
  int index;
  var idKey;
  newContainer({
    required this.imageUrl,
    required this.starNumber,
    required this.title,
    required this.index,
    required this.idKey,
  });
  @override
  State<newContainer> createState() => _newContainerState();
}

class _newContainerState extends State<newContainer> {
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
              idKey: widget.idKey,
              index: widget.index,
            ),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
          ),
        );
      }),
      child: Container(
        height: 280,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 120,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(widget.imageUrl))), ///// IMAGE
            ),
            Container(
              width: 220,
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Text(
                    '${widget.title.toString().substring(0, 50)} ... ',

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
          ],
        ),
      ),
    );
  }
}
