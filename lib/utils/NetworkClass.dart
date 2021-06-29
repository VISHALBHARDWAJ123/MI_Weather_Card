import 'package:http/http.dart';

class NetworkingClass {
  //Please use your api_key for this project.
  //You can get your own api key from openweathermap.org
  final String api_Key = 'b44d0637df0e472548779c95607223e9';

  Future getWeather(double latitude, double longitude) async {
    Uri myBaseUrl = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$api_Key&units=metric');

    var response = await get(myBaseUrl);
    var responseString;
    if (response.statusCode == 200) {
      responseString = response.body;
      return responseString;
    } else {
      return '';
    }
  }

  Future getCityWeather(String cityName) async {
    Uri myBaseUrl = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$api_Key&units=metric');
    var response = await get(myBaseUrl);
    var responseString;
    if (response.statusCode == 200) {
      responseString = response.body;
      return responseString;
    } else {
      return '';
    }
  }


  Future<void> getForcast() async{

  }

}
