import 'package:flutter/material.dart';
import './search.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../utils/utils.dart' as util;
import 'package:http/http.dart' as http;

var dateFormat;
var timeFormat;

class City extends StatefulWidget {
  final String city;

  City({Key key, this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new CityState();
  }
}

class CityState extends State<City> {
  String _city;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("fi_FI", null);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: new Text("WeatherApp"),
        actions: <Widget>[
//					new IconButton(
//						icon: new Icon(Icons.my_location), onPressed: null
//					),

          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              searchCity(context);
            },
          ),
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            showCity(),
            new Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0)),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      updateCurrentWeatherIcon(_city),
                    ],
                  )),
                  new Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        updateCurrentWeatherWidget(_city, "main", "temp", "ºC"),
                        updateCurrentWeatherWidget(
                            _city, "main", "humidity", "%"),
                        updateCurrentWeatherWidget(
                            _city, "wind", "speed", "m/s"),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            new Divider(
              height: 15.0,
              color: Colors.white,
            ),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(child: sunriseSunsetWidget(_city, "sunrise")),
                  new Expanded(child: sunriseSunsetWidget(_city, "sunset")),
                ],
              ),
            ),
            new Divider(
              height: 15.0,
              color: Colors.white,
            ),
            new Text(
              "5 day / 3 Hour Forecast",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            new SafeArea(child: weekForecast(_city)),
          ],
        ),
      ),
    );
  }

  //Futures

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=metric";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Future<Map> hourWeather(String appId, String city) async {
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=${util.appId}&units=metric";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Future searchCity(BuildContext context) async {
    Map result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Search();
    }));

    if (result != null && result.containsKey("city")) {
      _city = result['city'].toString();
    } else {
      print("Nothing");
    }
  }

  Widget showCity() {
    return new Center(
      child: new Text(
        _city == null ? util.defaultCity : _city,
        style: new TextStyle(fontSize: 35.0, color: Colors.white),
      ),
    );
  }

  //Widget for current weather
  Widget updateCurrentWeatherWidget(String city, String jsonObject, String jsonField, String suffix) {
    return new FutureBuilder(
        future: getWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                    child: new Text(
                      "${content['$jsonObject']['$jsonField'].toString()} $suffix",
                      style: new TextStyle(fontSize: 25.0, color: Colors.white),
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

  Widget updateCurrentWeatherIcon(String city) {
    return new FutureBuilder(
        future: getWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return new Image.asset(
              "assets/images/${content['weather'][0]['main']}.png",
              height: 150.0,
              width: 150.0,
            );
          } else {
            return new Image.asset(
              "assets/images/Clear.png",
              height: 150.0,
              width: 150.0,
            );
          }
        });
  }

  //Widget for sunset - sunrise weather
  Widget sunriseSunsetWidget(String city, String riseOrSet) {
    return FutureBuilder(
        future: getWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;

            dateFormat = new DateFormat.Hm();
            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                content['sys']['$riseOrSet'] * 1000);
            var _date = dateFormat.format(date);

            return new Column(
              children: <Widget>[
                new Image.asset(
                  riseOrSet == "sunrise"
                      ? "assets/images/sunrise.png"
                      : "assets/images/sunset.png",
                  height: 50.0,
                  width: 50.0,
                ),
                new Text(
                  "$_date",
                  style: new TextStyle(color: Colors.white),
                ),
              ],
            );
          } else {
            return new Container();
          }
        });
  }

  //Widget for 5day / 3 Hour weather
  Widget weekForecast(String city) {
    return FutureBuilder(
        future: hourWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            List _days = content['list'];

            return new Container(
              height: 180.0,
              child: ListView.builder(
                  itemCount: _days.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, position) {
                    final int index = position + 1;

                    dateFormat = new DateFormat("E d/M", "en_US");
                    timeFormat = new DateFormat.jm();

                    DateTime date = DateTime.fromMillisecondsSinceEpoch(
                        _days[index]['dt'] * 1000);
                    DateTime time = DateTime.fromMillisecondsSinceEpoch(
                        _days[index]['dt'] * 1000);

                    var _date = dateFormat.format(date);
                    var _time = timeFormat.format(time);

                    double temp = _days[index]['main']['temp'];

                    return new Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "$_date",
                            style: new TextStyle(color: Colors.white),
                          ),
                          new Text(
                            "$_time",
                            style: new TextStyle(color: Colors.white),
                          ),
                          new Padding(padding: EdgeInsets.only(top: 10.0)),
                          new Image.asset(
                            "assets/images/${_days[index]['weather'][0]['main'].toString()}.png",
                            height: 40.0,
                            width: 40.0,
                          ),
                          new Text(
                            "${temp.round()} ºC",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 18.0),
                          ),
                          new Text(
                            "${_days[index]['wind']['speed']} %",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return new Container();
          }
        });
  }
}
