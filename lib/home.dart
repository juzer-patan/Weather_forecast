import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:animation_test/services/weatherapi.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  String place;
  String temp;
  String condition;
  String temp_max;
  String temp_min;
  String description;
  String lat;
  String lon;
  String icon_file;
  TextEditingController searchController = new TextEditingController();
  AnimationController _controller;
  Animation place_text;
  Animation description_text;
  Animation temp_text;
  Animation latlon_text;
  Animation maxmin_text;
  Animation place_opac;
  Animation description_opac;
  Animation temp_opac;
  Animation maxmin_opac;
  Animation icon_opac;
  List<Color> color_list;
  var begin;
  var end;
  var stops;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    description_text = Tween(
      begin: 0.0,
      end: 30.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.8, 1.0)));
    place_text = Tween(
      begin: 0.0,
      end: 40.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.2)));
    temp_text = Tween(
      begin: 0.0,
      end: 40.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.35, 0.5)));
    latlon_text = Tween(
      begin: 0.0,
      end: 18.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.35)));
    maxmin_text = Tween(
      begin: 0.0,
      end: 18.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.65)));

    description_opac = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.8, 1.0)));
    place_opac = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.2)));
    temp_opac = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 0.5, curve: Curves.decelerate)));
    maxmin_opac = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.65, curve: Curves.decelerate)));
    icon_opac = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.65, 0.8, curve: Curves.decelerate)));    
    _controller.addListener(() {
      setState(() {
        //print(first_text.value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  changeName() {
    setState(() {
      print(_controller.value);
      //name="Juzer";
      //username="juzerp";
      _controller.forward(from: 0.0);
    });
  }

  testConditions() {
    setState(() {
      condition = "thunderstorm";
      temp = 27.toString();
      place = searchController.text;
      lat = 81.0.toString();
      lon = 132.toString();
      temp_max = 28.toString();
      temp_min = 26.toString();
      description = "Broken Rain";
      if (condition == "thunderstorm") {
        icon_file = "assets/Drizzle (1).png";
      }
      _controller.forward(from: 0.0);
    });
  }

  getConditions() async {
    if (searchController.text.isNotEmpty) {
      var result = await WeatherApi.getWeather(searchController.text);
      print(result);
      if (result != null) {
        print(result.isDay);
        print(result.condition);
        var condition = result.condition;
        double temp_cel = result.temp - 273.15;
        int temp_round = temp_cel.round();
        var tempmax_round = (result.temp_max - 273.15).round();
        var tempmin_round = (result.temp_min - 273.15).round();
        setState(() {
          if (condition == "Thunderstorm") {
            color_list = [Colors.blue.shade900, Colors.white70];
            begin = Alignment.topCenter;
            end = Alignment.bottomCenter;
            stops = [-0.2, 0.8];
            icon_file = "assets/Thunderstorm.png";
          } else if (condition == "Drizzle") {
            color_list = [Colors.blueGrey, Colors.white];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.5, 1.0];
            icon_file = "assets/Drizzle (1).png";
          } else if (condition == "Rain") {
            color_list = [Colors.blueGrey, Colors.white];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.5, 1.0];
            icon_file = "assets/Rain.png";
          } else if (condition == "Fog" || condition == "Mist") {
            color_list = [Colors.grey, Colors.white];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.5, 1.0];
            icon_file = "assets/Fog.png";
          } else if (condition == "Snow") {
            color_list = [Colors.blue, Colors.white70];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.5, 1.0];
            icon_file = "assets/snow.png";
          } else if (condition == "HeavyCloud") {
            color_list = [Colors.grey, Colors.white];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.5, 1.0];
            icon_file = "assets/light_cloud.png";
          } 
          else if (condition == "LightCloud") {
            color_list = [Colors.lightBlue, Colors.white70];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.0, 1.0];
            icon_file = "assets/light_cloud.png";
          }
            else if (condition == "Clear" && result.isDay) {
            color_list = [Colors.blue.shade900, Colors.white70];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.0, 1.0];
            icon_file = "assets/Clearsky_day.png";
          } else if (condition == "Clear" && !result.isDay) {
            color_list = [
              Colors.blueGrey.shade700,
              Colors.black45,
            ];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.5, 1.0];
            icon_file = "assets/Clearsky_night.png";
          } else if (condition == "Atmosphere") {
            color_list = [Colors.amber, Colors.white];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.3, 1.0];
            icon_file = "assets/tornado.png";
          } else {
            color_list = [Colors.amber, Colors.white];
            begin = Alignment.topLeft;
            end = Alignment.bottomRight;
            stops = [0.3, 1.0];
            //  ico
          }
          temp = temp_round.toString();
          description = result.description.toString()[0].toUpperCase() + result.description.toString().substring(1);
          temp_max = tempmax_round.toString();   
           temp_min = tempmin_round.toString();
           lat = result.lat.toString();
           lon = result.long.toString();          
          place = result.name;
          _controller.forward(from: 0.0);
          print(place);
        });

        // description = result.description;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ,
      body: AnimatedContainer(
        duration: Duration(seconds: 4),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: begin != null ? begin : Alignment.topLeft,
                end: end != null ? end : Alignment.bottomRight,
                colors: color_list != null
                    ? color_list
                    : [Colors.amber, Colors.white],
                stops: stops != null ? stops : [0.3, 1.0]
                  
               )),
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: MediaQuery.of(context).size.height * 0.08),
        child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
            children: [
              Card(
                shadowColor: Colors.black,
                elevation: 20.0,
                child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: TextField(
                            
                            decoration: InputDecoration(
                                hintText: "Search City...",
                                hintStyle: TextStyle(
                                    //fontSize: 2,
                                    color: Colors.black87),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white))),
                            controller: searchController,
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.search,
                          ),
                          onPressed: () {
                            //testConditions();
                            
                            getConditions();
                          })
                    ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Opacity(
                opacity: place_opac.value,
                child: Text(
                    place != null ? place.toUpperCase() : 'Anyhting',
                    style: GoogleFonts.exo2(
                      //color: Colors.black54,
                      fontSize: place_text.value,
                      fontWeight: FontWeight.w600
                    )
                 // TextStyle(
                        
                      // fontStyle: FontStyle.italic, 
                    //  fontWeight: FontWeight.w700,
               //     fontSize: place_text.value,
               //   ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: latlon_text.value,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Opacity(
                          opacity: place_opac.value,
                          child: Text(
                            lat != null ? lat + "," + lon : 'Anyhting',
                            style: GoogleFonts.exo2(
                      color: Colors.black54,
                      fontSize: latlon_text.value,
                      fontWeight: FontWeight.w500
                    )
                          ),
                        ),
                      ),
                    ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Row(
                //mainAxisAlignment: Ma,
                children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: temp_opac.value,
                            child: Text(
                              temp != null ? temp + "°C" : 'Something',
                              style: GoogleFonts.exo2(
                      //color: Colors.black54,
                      fontSize: temp_text.value,
                      fontWeight: FontWeight.w600
                    )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Opacity(
                              opacity: maxmin_opac.value,
                              child: Text(
                                temp_max != null
                                    ? "Max  " + temp_max + "°C"
                                    : 'Something',
                                style: GoogleFonts.exo2(
                      //color: Colors.black54,
                      fontSize: maxmin_text.value,
                      fontWeight: FontWeight.w500
                    )
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: maxmin_opac.value,
                            child: Text(
                              temp_min != null
                                  ? "Min  " + temp_min + "°C"
                                  : 'Something',
                              style: TextStyle(
                                  //fontWeight: FontWeight.w600,
                                  fontSize: maxmin_text.value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: icon_opac.value,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.17,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: icon_file != null
                              ? Image.asset(
                                  icon_file,
                                )
                              : Container(),
                        ),
                      ),
                    )
                ],
              ),
              Opacity(
                opacity: description_opac.value,
                child: Text(
                    description ?? 'Anyhting',
                    style: GoogleFonts.exo2(
                      //color: Colors.black54,
                      fontSize: description_text.value,
                      fontWeight: FontWeight.w500
                    )
                ),
              ),
            ],
          ),
                  ),
        ),
      ),
    );
  }
}
