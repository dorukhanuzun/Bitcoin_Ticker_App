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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '27B893E6-E70E-4C05-8C23-8E18FF7AD19D';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //TODO 5: Return a Map of the results instead of a single value.
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      //Update the URL to use the crypto symbol from the cryptoList
      http.Response response = await http
          .get('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey');
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
