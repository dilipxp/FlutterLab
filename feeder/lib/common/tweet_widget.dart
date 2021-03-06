import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TweetWidget extends StatefulWidget {

  final Widget child;

  const TweetWidget({Key key, @required this.child}) : super(key: key);

  @override
  _TweetWidgetState createState() => _TweetWidgetState();
}

class _TweetWidgetState extends State<TweetWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(

        color: HexColor("#D6E6F2"),
        margin: EdgeInsets.all(4),
        elevation: 10 ,
          child: Container(
              child: widget.child,
            margin: EdgeInsets.only(top: 5, bottom: 5),
          )           // Do Not Delete this
    );
  }
}
