import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/location_page.dart';
import 'package:weather_app/model/weather_response_model.dart';
import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/widgets/weekly_forecast_widget.dart';

import 'widgets/current_weather_details.dart';
import 'widgets/today_hourly_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String myLocation = "";
  WeatherResponseModel weatherResponse = WeatherResponseModel();

  String _getHours(int hourAddition) {
    DateTime date = DateTime.now();

    DateTime newDate = date.add(Duration(hours: hourAddition));
    String hour = "${DateFormat('HH').format(newDate)}:00";
    return hour;
  }

  String _getHourTemp(int hourAddition) {
    String currentHr = _getHours(hourAddition);
    List<Hour> hourList = [];

    if (weatherResponse.forecast?.forecastday?[0].hour != null) {
      hourList = weatherResponse.forecast?.forecastday?[0].hour ?? [];

      if (hourList.isNotEmpty) {
        for (int i = 0; i < hourList.length; i++) {
          String time = hourList[i].time ?? "";
          if (time.contains(currentHr)) {
            return hourList[i].tempC?.toStringAsFixed(1) ?? '';
          }
        }
      }
    }
    return "";
  }

  String _convertDateToMMMdd(String inputDate) {
    if (inputDate.isNotEmpty) {
      DateTime inputDateTime = DateTime.parse(inputDate);

      String newDate = DateFormat("MMM, dd").format(inputDateTime);

      return newDate;
    }
    return "";
  }

  bool _isDay(String inputDate) {
    if (inputDate.isNotEmpty) {
      DateTime inputDateTime = DateTime.parse(inputDate);

      if (inputDateTime.hour > 6 && inputDateTime.hour < 18) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                _isDay(weatherResponse.current?.lastUpdated ?? "")
                    ? [Color(0xFF29B2DD), Color(0xFF33AADD), Color(0xFF2DC8EA)]
                    : [Color(0xFF08244F), Color(0xFF134CB5), Color(0xFF0B42AB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.47, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // FIRST ROW LOCATION AND NOTIFICATION
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              var userInput = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LocationPage(),
                                ),
                              );

                              if (userInput != null) {
                                ApiService apiService = ApiService();
                                WeatherResponseModel? responseModel;

                                if (userInput is LatLng) {
                                  responseModel = await apiService
                                      .getWeatherDataFromUserInput(
                                        lat: userInput.latitude.toString(),
                                        long: userInput.longitude.toString(),
                                      );
                                } else if (userInput is Position) {
                                  responseModel = await apiService
                                      .getWeatherDataFromUserInput(
                                        lat: userInput.latitude.toString(),
                                        long: userInput.longitude.toString(),
                                      );
                                } else if (userInput is String) {
                                  if (userInput.isNotEmpty) {
                                    setState(() {
                                      myLocation = userInput;
                                    });

                                    responseModel = await apiService
                                        .getWeatherDataFromUserInput(
                                          cityName: userInput,
                                        );
                                  }
                                }

                                if (responseModel != null) {
                                  setState(() {
                                    myLocation =
                                        responseModel?.location?.name ?? '';
                                    weatherResponse = responseModel!;
                                  });
                                }
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: Colors.white,
                                  size: 27,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  myLocation,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 27,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0),
                        SvgPicture.asset("assets/icons/notification.svg"),
                      ],
                    ),
                  ),

                  // SECOND ROW IMAGE
                  Image.asset(
                    "assets/icons/sun_cloud.png",
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "${weatherResponse.current?.tempC ?? 0}º",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // SizedBox(height: ,)
                  Text(
                    "Precipitations\nMax.: ${weatherResponse.forecast?.forecastday?[0].day?.maxtempC}º Min.: ${weatherResponse.forecast?.forecastday?[0].day?.mintempC}º",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),

                  // THIRD ROW
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    margin: EdgeInsets.only(top: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFF001026).withValues(alpha: 0.5),
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CurrentWeatherDetails(
                          path: "rain",
                          label: "${weatherResponse.current?.precipMm ?? 0.0}%",
                        ),
                        CurrentWeatherDetails(
                          path: "humidity",
                          label: "${weatherResponse.current?.humidity ?? 0}%",
                        ),
                        CurrentWeatherDetails(
                          path: "wind",
                          label:
                              "${weatherResponse.current?.windKph ?? 0.0}km/h",
                        ),
                      ],
                    ),
                  ),

                  // TODAY'S WEATHER
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFF001026).withValues(alpha: 0.5),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            Text(
                              _convertDateToMMMdd(
                                weatherResponse.current?.lastUpdated ?? '',
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TodayHourlyWidget(
                              isSelected: false,
                              currentHour: _getHours(-1),
                              temp: _getHourTemp(-1),
                            ),
                            TodayHourlyWidget(
                              isSelected: true,
                              currentHour: _getHours(0),
                              temp: _getHourTemp(0),
                            ),
                            TodayHourlyWidget(
                              isSelected: false,
                              currentHour: _getHours(1),
                              temp: _getHourTemp(1),
                            ),
                            TodayHourlyWidget(
                              isSelected: false,
                              currentHour: _getHours(2),
                              temp: _getHourTemp(2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // WEEKLY WEATHER
                  WeeklyForecastWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// String currentHour = _getHours(hourAddition);
//
// if (weatherResponse.forecast != null) {
// List<Hour> hourList =
// weatherResponse.forecast?.forecastday?[0].hour ?? [];
//
// if (hourList.isNotEmpty) {
// for (int i = 0; i < hourList.length; i++) {
// if (hourList[i].time?.contains(currentHour) ?? false) {
// String  temp = hourList[i].tempC?.toStringAsFixed(1) ?? "";
// print(temp);
// return temp;
// }
// }
// }
// }
// return "";
