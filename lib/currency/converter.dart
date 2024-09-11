
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter {
  static Future<double> convert({
    required double amount,
    required String from,
    required String to,
  }) async {
    final url = 'https://api.exchangerate-api.com/v4/latest/$from';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final rates = json.decode(response.body)['rates'];
      final rate = rates[to];
      return amount * rate;
    } else {
      throw Exception('erro');
    }
  }
}
