import 'package:flutter/material.dart';

class Location extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new LocationState();
  }

}

class LocationState extends State<Location>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

	    backgroundColor: Theme.of(context).backgroundColor,

	    body: new Container(
		    padding: EdgeInsets.all(10.0),
		    child: new ListView(
			    children: <Widget>[

			    	new Text(
					    "This is Location based screen",
					    style: new TextStyle(
						    fontSize: 30.0,

					    ),

				    ),



			    ],
		    ),
	    ),




    );
  }
}