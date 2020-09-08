import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const List<String> currencyType = ['CAD', 'EUR', 'GBP', 'RS', 'USD'];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];
const String _apikey = 'BE4368EF-8876-4FC4-B0E7-864F49472B919';
const String _baseURL = 'https://rest.coinapi.io/v1/exchangerate/';

class CryptoToRegular {
  var _cryptoToReg = {};

  CryptoToRegular() {
    for (String eachCryptoType in cryptoList) {
      _cryptoToReg[eachCryptoType] = '?';
    }
  }

  dynamic convertCryptoToRegularBP() {
    return _cryptoToReg;
  }

  dynamic convertCryptoToRegular({String currencyType}) async {
    for (String eachCryptoType in cryptoList) {
      String url =
          _baseURL + eachCryptoType + '/' + currencyType + '?apikey=$_apikey';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var conversionRate = jsonResponse['rate'];
        double conversionRateDouble = double.parse(conversionRate.toString());

        _cryptoToReg[eachCryptoType] = conversionRateDouble.toStringAsFixed(2);
      } else
        _cryptoToReg[eachCryptoType] = "NF" + response.statusCode.toString();
    }
    print("****************+++++++++");
    print(_cryptoToReg);
    return _cryptoToReg;
  }
}
