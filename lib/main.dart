import 'package:flutter/material.dart';
import 'package:topper_news/top_news.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hacker news",
      home: TopNewsList(),
    );
  }
}


