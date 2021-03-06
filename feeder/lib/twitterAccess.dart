import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TwitterAccess {
  final twitterApi = TwitterApi(
    client: TwitterClient(
     // consumerKey: 'You can get your twitter api on twitter developer portal',
     // consumerSecret: 'You can get your twitter api on twitter developer portal',
     // token: 'You can get your twitter api on twitter developer portal',
     // secret: 'You can get your twitter api on twitter developer portal',
    ),
  );

  Future<List<Tweet>> feeds() async {
    try {
      // Get the last 200 tweets from your home timeline
      final homeTimeline = await twitterApi.timelineService.homeTimeline(
          count: 100, includeEntities: true, tweetMode: 'extended', excludeReplies: true);
      return homeTimeline;
      // Print the text of each Tweet
    } catch (error) {
      return error;
    }
  }

  /// tweets from http

}
