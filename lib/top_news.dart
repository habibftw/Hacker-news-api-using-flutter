import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:topper_news/story.dart';
import 'package:topper_news/api_service.dart';
import 'comment_list_page.dart';

class TopNewsList extends StatefulWidget {
//  const TopNewsList({Key key}) : super(key: key);

  @override
  _TopNewsListState createState() => _TopNewsListState();
}

class _TopNewsListState extends State<TopNewsList> {

  List<Story> _stories = List<Story>();

  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {

    final responses = await Webservice().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();

    setState(() {
      _stories = stories;
    });
  }

  void _navigateToShowCommentsPage(BuildContext context, int index) async {

    final story = this._stories[index];
    final responses = await Webservice().getCommentsByStory(story);
    final comments = responses.map((response) {
      final json = jsonDecode(response.body);
      return Comment.fromJson(json);
    }).toList();

    debugPrint("$comments");

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentListPage(story: story, comments: comments)
    ));


  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hacker News"),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: _stories.length,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () {
                _navigateToShowCommentsPage(context, index);
              },
              title: Text(_stories[index].title, style: TextStyle(fontSize: 18)),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      //borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("${_stories[index].commentIds.length}",style: TextStyle(color: Colors.white)),
                  )
              ),
            );
          },
        )
    );

  }
}
