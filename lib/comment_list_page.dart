import 'package:flutter/material.dart';
import 'package:topper_news/story.dart';

class CommentListPage extends StatelessWidget {


  final List<Comment> comments;
  final Story story;

  CommentListPage({this.story, this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.story.title),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: this.comments.length,
          itemBuilder: (comments, index){
          return ListTile(
            leading: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text("${1+index}",style: TextStyle(fontSize: 22, color: Colors.white),),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(this.comments[index].text, style: TextStyle(fontSize: 18),),
            ),
          );
          }),
    );
  }
}
