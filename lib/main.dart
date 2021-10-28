import 'package:weather_temp/data_service.dart';
import 'package:flutter/material.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(
                fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (_response == null)
                Container(
                    height: 250,
                    width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/images/weather.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              if (_response != null)
                Container(
                  height: 250,
                  width: double.infinity,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.network(_response.iconUrl),
                      Text(
                        '${_response.tempInfo.temperature}°',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        _response.weatherInfo.description,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Humidity: ${_response.tempInfo.humidity}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        'Pressure: ${_response.tempInfo.pressure}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(labelText: 'City'),
                      textAlign: TextAlign.center),
                ),
              ),
              ElevatedButton(
                onPressed: _search,
                child: Text(
                  'Search',
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  fixedSize: MaterialStateProperty.all<Size>(Size(150.0, 30.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
