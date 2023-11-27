import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin {

  HttpAdmin();

  Future<double> pedirTemperaturasEn (double lat, double long) async {
      var url = Uri.https('api.open-meteo.com', '/v1/forecast',
          {'latitude': lat.toString(),
          'longitude': long.toString(),
          'hourly': 'temperature_2m'
          });
      print ("URL Resultante: " + url.toString());

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map <String, dynamic>;
        //print("Mapa entero: " + jsonResponse.toString());
        var horas = jsonResponse['hourly_units'];
        //print("Unidad horaria: " + horas.toString());
        //print("Horas: " + jsonResponse['hourly'].toString());
        //var itemCount = jsonResponse['totalItems'];
        //print('Number of books about http: $itemCount.');
        DateTime now = DateTime.now();
        int hour = now.hour;

        var jsonHourly = jsonResponse['hourly'];
        var jsonTimes = jsonHourly['time'];
        var jsonTiempo0 = jsonTimes[hour];
        var jsonTemperaturas = jsonHourly['temperature_2m'];
        var jsonTemperatura0 = jsonTemperaturas[hour];
        //print ('Temperaturas: jsonTemperaturas.toString());
        //print('la temperatura en a las ' + jsonTiempo0.toString() + ' fue ' + jsonTemperatura0.toString());
        //print ("TIEMPO : "+jsonHourly['time'].toString());
        //print ("TIEMPO EN LA POSICION O : "‡jsonResponse!'hourly'Il'time'][0]. toString());
        //var itemcount = jsonResponse['totalItems'];
        //print('Number of books about http: SitemCount.');
        return jsonTemperatura0;

      } else {
        print('Request failed with status: ${response.statusCode}.');
        return 0;
      }
  }
}