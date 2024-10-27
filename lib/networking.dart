import 'dart:convert';
import 'package:http/http.dart';

const url =
    "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=8E8FC6C1-91E7-4AEA-B5B1-A626E32D594E";
/////BTC/USD?apikey=
///
const URL = "https://rest.coinapi.io/v1/exchangerate/BTC/";

///
const APIKEY = "8E8FC6C1-91E7-4AEA-B5B1-A626E32D594E";

class NetworkHelper {
  NetworkHelper();

  Future getData(String currency) async {
    var response = await get(Uri.parse("$URL$currency?apikey=$APIKEY"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      String data = response.body;

      var returned = jsonDecode(data);
      return returned["rate"].toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
