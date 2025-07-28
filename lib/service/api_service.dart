import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_response_model.dart';

class ApiService {
  final String baseUrl = "https://api.weatherapi.com/v1/";
  final String apiKey = "414ace58f0c6403f9e1164448251002";

  Future<WeatherResponseModel?> getWeatherDataFromUserInput({
    String? cityName,
    String? lat,
    String? long,
  }) async {

    String userInput = "";
    if(cityName != null) {
      userInput = cityName;
    } else if(lat!=null && long!=null) {
      userInput = "$lat,$long";
    }

    var url = Uri.parse(
      "${baseUrl}forecast.json?q=$userInput&days=8&key=$apiKey",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      WeatherResponseModel responseModel = weatherResponseModelFromJson(
        response.body,
      );

      return responseModel;
    }
    return null;
  }
}
