import 'package:flutter/material.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }


}

class SearchState extends State<Search> {

	final TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
	    backgroundColor: Theme.of(context).backgroundColor,
	    
	    body: new Container(
		    padding: EdgeInsets.all(10.0),
		    child: new ListView(

			    children: <Widget>[
			    	new TextField(
					    controller: searchController,
					    decoration: new InputDecoration(
						    icon: new Icon(Icons.search),
						    hintText: "Type location",

					    ),
				    )



			    ],
		    ),
	    ),
	    
	    
	    
    );
  }
}