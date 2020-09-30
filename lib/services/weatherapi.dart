import 'dart:convert';

import 'package:animation_test/services/weatherJson.dart';
import 'package:http/http.dart' as http;
class WeatherApi {
  static getWeather(String city) async{
    String url = "http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=21881a7c4c41ba5473cb5ed70ea92214";
    var response = await http.get(url);
    
    return Weather.fromJson(jsonDecode(response.body));
  }


}