import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }
}

class SearchState extends State<Search> {
  var searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: new Text("Search"),
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Colors.blue[900],
              Colors.blue[800],
              Colors.blue[500],
              Colors.blue[300],
            ],
          ),
        ),
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new TextField(
                controller: searchController,
                style: new TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  icon: new Icon(Icons.search, color: Colors.white,),
                  hintText: "Type City",
                  hintStyle: new TextStyle(
                    color: Colors.white,
                  ),


                ),
              ),
            ),
            new ListTile(
              title: new FlatButton(
                child: new Text("Send to Next Screen"),
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pop(context, {
                    'city': searchController.text,
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
