import 'package:flutter/material.dart';

class Search extends StatefulWidget{
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
	    
	    body: new ListView(

			    children: <Widget>[
			    	
			    	
			    	new ListTile(
			    	  title: new TextField(
					      controller: searchController,
					      decoration: new InputDecoration(
						      icon: new Icon(Icons.search),
						      hintText: "Type City",

					      ),
				      ),
			    	),



				    new ListTile(
				      title: new FlatButton(
					      child: new Text("Send to Next Screen"),
					      textColor: Colors.white,
					      color: Theme.of(context).accentColor,
					      onPressed: (){
					      	Navigator.pop(context, {
					      		'city': searchController.text,
						      });

					      },
				      ),
				    ),


			    ],
		    ),
	    );

  }


}