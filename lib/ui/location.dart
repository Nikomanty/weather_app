import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import '../utils/utils.dart' as util;
import 'package:http/http.dart' as http;

class Location extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new LocationState();
  }

}

class LocationState extends State<Location>{

	void showStuff() async {
		Map data = await getWeather(util.appId, util.defaultCity);
		print(data.toString());
		print(data['main']['temp']);
	}


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
								    child: Padding(
									    padding: EdgeInsets.only(left: 50.0),
								      child: Column(
									    crossAxisAlignment: CrossAxisAlignment.start,
									    children: <Widget>[
										    updateMainWeatherWidget("Oulu", "main", "temp", "ºC"),
										    updateMainWeatherWidget("Oulu", "main", "humidity", "%"),
										    updateMainWeatherWidget("Oulu", "main", "temp", "mm"),
										    updateMainWeatherWidget("Oulu", "wind", "speed", "m/s"),

									    ],
								      ),
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
											    new Image.asset("assets/images/light_rain.png", height: 48.0, width: 48.0),
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
												    new Image.asset("assets/images/light_rain.png", height: 48.0, width: 48.0),
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

  Future<Map> getWeather(String appId, String city) async {
  	String apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=metric";

  	http.Response response = await http.get(apiUrl);

  	return json.decode(response.body);

  }

  Widget updateMainWeatherWidget(String city, String jsonObject, String jsonField, String suffix){
		return new FutureBuilder(
			future: getWeather(util.appId, city),

			builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
				if(snapshot.hasData){
					Map content = snapshot.data;
					return new Container(
						child: new Column(
							mainAxisAlignment: MainAxisAlignment.end,
							children: <Widget>[

								new Padding(
									padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
									child: new Text(
										"${content['$jsonObject']['$jsonField'].toString()} $suffix",
										style: new TextStyle(fontSize: 25.0),
									),
								),



//				      new ListTile(
//									title:
//								),


							],
						),
					);
				} else {
					return new Container();
				}

			});
  }



}