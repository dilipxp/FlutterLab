import 'dart:async';
import 'package:dart_twitter_api/api/media/data/media.dart';
import 'package:dart_twitter_api/api/tweets/data/tweet.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:feeder/common/tweet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'twitterAccess.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feeder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Feeds(),
      home: Feeds(),
    );
  }
}


class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {

    var num ;
    final _feeds = TwitterAccess();
    bool indicate = true;

    String darkBlue = "#303841";
    String lightBlue = "#D6E6F2";
    String smokyWhite = "#F5F5F5";



    Future _indicate() async{
    setState(() {
      if(indicate == true){indicate = !indicate;}
      print('refreshed');

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(smokyWhite),
      appBar: AppBar(
        title: Icon(
            EvaIcons.twitter,
          color: HexColor(lightBlue),
        ),
        centerTitle: true,
        backgroundColor: HexColor(darkBlue),
      ),

      body: RefreshIndicator(
        onRefresh: _indicate,
        color: HexColor(lightBlue),
        backgroundColor: HexColor(darkBlue),
        child: Center(
          child: SingleChildScrollView(

            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<Tweet>>(
             future: indicate ? _feeds.feeds() : _feeds.feeds(),
             // future: _feeds.feeds(),
              builder: (BuildContext context, AsyncSnapshot<List<Tweet>> snapshot )  {
                List<Widget> children;
                if (snapshot.hasData){
                  children = <Widget>[
                    for(var tweet in snapshot.data)
                      TweetWidget(

                        child: Row(
                             mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(tweet.user.profileImageUrlHttps,
                              alignment: Alignment.topLeft,
                                width: 40,
                                height: 40,
                              ),
                            ),
                            SizedBox(width: 20,),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SelectableText(
                                    '${tweet.fullText}\n',
                                    textAlign: TextAlign.left,
                                    toolbarOptions: ToolbarOptions(copy: true, cut: true),
                                    scrollPhysics: ClampingScrollPhysics(),
                                  ),

                                  Image.network('https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                    height: 200,
                                    width: 400,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )


                      ),
                    TweetWidget(
                      child: Text("Refresh for New Tweets!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: HexColor(darkBlue)),
                      ),
                    )
                  ];


                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: Oh! Snap, restart the app'),
                      ),
                    )
                  ];
                }else {
                  children = <Widget>[
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       SizedBox(
                         child: CircularProgressIndicator(backgroundColor: HexColor(lightBlue),),
                         width: 60,
                         height: 60,
                       ),
                       const Padding(
                         padding: EdgeInsets.only(top: 16),
                         child: Text('Awaiting result...'),
                       )
                     ],
                   )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
        ),
      )
      );
  }
}