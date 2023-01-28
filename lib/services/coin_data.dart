// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// --url      https://rest.coinapi.io/v1/exchangerate/BTC/USD \
const apiURL = 'https://rest.coinapi.io/v1/exchangerate';
// --header   "X-CoinAPI-Key: 73034021-THIS-IS-SAMPLE-KEY"
const apiKey = 'DEEA9CBA-AE4D-428F-ACA6-3C587ACE683F';

class CoinData {
  Future<dynamic> getCoinData([String? currency = 'AUD']) async {
    Map<String, String> results = {};

    for (String crypto in cryptoList) {
      // fetch dta from api
      http.Response response = await http.get(
        Uri.parse('$apiURL/$crypto/$currency'),
        headers: {"X-CoinAPI-Key": apiKey},
      );

      if (response.statusCode == 200) {
        // if success then extract the data from JSON
        var extractedData = jsonDecode(response.body);
        double lastPrice = extractedData["rate"];

        results[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        // if failed show the status
        print(response.statusCode);
      }
    }
    // print(results);
    return results;
  }
}
