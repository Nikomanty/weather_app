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
					    "Oulu",
					    style: new TextStyle(
						    fontSize: 35.0,

					    ),
				    ),

			    	new Padding(
					    padding: EdgeInsets.only(left: 15.0),
					    child: new Text(
						    "Finland",
						    style: new TextStyle(
							    fontSize: 25.0,

						    ),
					    ),
				    ),

			    	new Padding(padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 0.0)),


			    	new Container(
					    child: new Row(
						    mainAxisAlignment: MainAxisAlignment.center,
						    children: <Widget>[

						    	new Expanded(
								    child: Column(
									    crossAxisAlignment: CrossAxisAlignment.center,
									    children: <Widget>[

									    	new Image.asset(
											    "assets/images/light_rain.png",
											    height: 150.0,
											    width: 150.0,
										    ),


									    ],
								    )
							    ),

							    new Expanded(
								    child: Column(
									    crossAxisAlignment: CrossAxisAlignment.center,
									    children: <Widget>[
									    	new Padding(
											    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
											    child: new Text(
												    "Temp ºC",
												    style: new TextStyle(
													    fontSize: 25.0,

												    ),
											    ),
										    ),

										    new Padding(
											    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
											    child: new Text(
												    "Temp ºC",
												    style: new TextStyle(
													    fontSize: 25.0,

												    ),
											    ),
										    ),

										    new Padding(
											    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
											    child: new Text(
												    "Temp ºC",
												    style: new TextStyle(
													    fontSize: 25.0,

												    ),
											    ),
										    ),

										    new Padding(
											    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
											    child: new Text(
												    "Temp ºC",
												    style: new TextStyle(
													    fontSize: 25.0,

												    ),
											    ),
										    ),



									    ],
								    )
							    ),

						    ],

					    ),
				    ),

				    new Divider(height: 15.0, color: Colors.black,),

				    new Text(
					    "Hour forecast",
					    style: new TextStyle(
						    fontSize: 20.0,

					    ),
				    ),

				    new SafeArea(
					    child: new Container(
						    height: 120.0,
						    child: ListView.builder(
							    itemCount: 10,
							    scrollDirection: Axis.horizontal,
							    itemBuilder: (BuildContext context, index){
								    return new Padding(
									    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
									    child: new Column(
										    mainAxisAlignment: MainAxisAlignment.center,
										    children: <Widget>[
											    new Text("10:00", style: new TextStyle(color: Colors.black),),
											    new Image.network('https://openweathermap.org/img/w/01d.png'),
											    new Text("+10 ºC", style: new TextStyle(color: Colors.black),),
											    new Text("2.0 mm", style: new TextStyle(color: Colors.black),),


										    ],
									    ),
								    );
							    }



						    ),
					    ),
				    ),

				    new Divider(height: 15.0, color: Colors.black,),

				    new Text(
					    "Week forecast",
					    style: new TextStyle(
						    fontSize: 20.0,

					    ),
				    ),

				    new SafeArea(
					    child: new Container(
							    height: 120.0,
							    child: ListView.builder(
								    itemCount: 10,
								    scrollDirection: Axis.horizontal,
								    itemBuilder: (BuildContext context, index){
								    	return new Padding(
										    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
										    child: new Column(
											    mainAxisAlignment: MainAxisAlignment.center,
											    children: <Widget>[
											    	new Text("12.10", style: new TextStyle(color: Colors.black),),
												    new Image.network('https://openweathermap.org/img/w/01d.png'),
												    new Text("+10 ºC", style: new TextStyle(color: Colors.black),),
												    new Text("2.0 mm", style: new TextStyle(color: Colors.black),),




											    ],
										    ),
									    );
								    }



							    ),
						    ),
				    ),


			    ],
		    ),
	    ),




    );
  }
}