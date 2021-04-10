import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; // time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool isDaytime; // if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      var uri = Uri.parse('https://worldtimeapi.org/api/timezone/$url');

      var response = await http.get(uri);

      Map data = jsonDecode(response.body);

      //print(data);

      //Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 17 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error: $e');
      time = 'Could not get time data';
    }
  }
}
