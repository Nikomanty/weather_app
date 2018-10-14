import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../utils/utils.dart' as util;
import 'package:http/http.dart' as http;



var dateFormat;
var timeFormat;

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
	    appBar: new AppBar(
		    title: new Text("WeatherApp"),


	    ),

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
											    "assets/images/rain_three_drop.png",
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
										    updateMainWeatherWidget("Oulu", "wind", "speed", "m/s"),
									      ],

								      ),
								    )
							    ),

						    ],

					    ),
				    ),



				    new Divider(height: 15.0, color: Colors.black,),

				    new Text("5 day / 3 Hour Forecast", style: new TextStyle(fontSize: 20.0,),),

				    new SafeArea(child: weekForecast("Oulu")),


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
	Future<Map> hourWeather(String appId, String city) async {
		String apiUrl = "http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=${util.appId}&units=metric";

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

							],
						),
					);
				} else {
					return new Container();
				}

			});
  }


  Widget weekForecast(String city){

		return FutureBuilder(
			future: hourWeather(util.appId, city),
			builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
				if(snapshot.hasData){
					Map content = snapshot.data;
					List _days = content['list'];

					return new Container(
						height: 150.0,
						child: ListView.builder(
							itemCount: _days.length,
							scrollDirection: Axis.horizontal,
							itemBuilder: (BuildContext context, position){

								return new Padding(
									padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
									child: new Column(
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget>[
											new Text("${_days[position]['dt_txt']}", style: new TextStyle(color: Colors.black),),
											new Padding(padding: EdgeInsets.only(top: 10.0)),
//											new Text("$_time", style: new TextStyle(color: Colors.black),),
											new Image.asset("assets/images/rain_three_drop.png", height: 60.0, width: 60.0),
											new Text("${_days[position]['main']['temp']} ºC", style: new TextStyle(color: Colors.black,),),
											new Text("${_days[position]['main']['humidity']} %", style: new TextStyle(color: Colors.black),),


										],
									),
								);

							}

						),
					);

				}else {
					return new Container();
				}


			}
		);

  }

