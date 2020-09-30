class Weather {
  String description;
  String condition;
  double temp;
  double temp_max;
  double temp_min;
  var lat;
  var long;  
  String name;
  bool isDay;
  Weather(
    {
      this.condition,
      this.description,
      this.temp,
      this.temp_max,
      this.temp_min,
      this.lat,
      this.long,
      this.name,
      this.isDay
    }
  );

  static Weather fromJson(current){
    var cloudiness = current['clouds']['all'];
    var weather = current['weather'][0];
    var date = DateTime.fromMillisecondsSinceEpoch(current['dt'] * 1000,
        isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        current['sys']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        current['sys']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);
    return Weather(
      temp: current['main']['temp'].toDouble(),
      temp_max: current['main']['temp_max'].toDouble(),
      temp_min: current['main']['temp_min'].toDouble(),
      description: weather['description'],
      condition: getCondition(weather['main'],cloudiness),
      lat: current['coord']['lat'].toString(),
      long: current['coord']['lon'].toString(),
      name : current['name'],
      isDay : isDay
    );
  }

  static getCondition(weather,cloudiness){
    String climate;
    switch (weather) {
      case 'Thunderstorm':
        climate = "Thunderstorm";
        break;
      case 'Drizzle':
        climate = 'Drizzle';
        break;
      case 'Rain':
        climate = 'Rain';
        break;
      case 'Snow':
        climate = 'Snow';
        break;
      case 'Clear':
        climate = 'Clear';
        break;
      case 'Clouds':

        climate = (cloudiness >= 85)
            ? 'HeavyCloud'
            : 'LightCloud';
        break;
      case 'Mist':
        climate = 'Mist';
        break;
      case 'Fog':
        climate = 'Fog';
        break;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        climate = 'Atmosphere';
        break;
      default:
        climate = 'Unknown';
    }
    return climate;
  }

}