import 'package:estudo_flutter/currency/converter.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final TextEditingController _controller = TextEditingController();
  double? _result;
  String _fromCurrency = 'BRL';
  String _toCurrency = 'USD';
  void _convert() async {
    double value = double.tryParse(_controller.text) ?? 0;
    _result = await CurrencyConverter.convert(
      amount: value,
      from: _fromCurrency,
      to: _toCurrency,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          'Conversor de Moedas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 80,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Digite o valor: ',
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                        ),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Converter de:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                              const SizedBox(height: 10),
                              _currencyDropdown(_fromCurrency, (newCurrency) {
                                setState(() {
                                  _fromCurrency = newCurrency!;
                                });
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Para:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                              const SizedBox(height: 10),
                              _currencyDropdown(_toCurrency, (newCurrency) {
                                setState(() {
                                  _toCurrency = newCurrency!;
                                });
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convert,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Converter'),
                    ),
                    const SizedBox(height: 20),
                    if (_result != null)
                      Text(
                        'Result: ${_result!.toStringAsFixed(2)} $_toCurrency',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent,),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _currencyDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent, width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: CurrencyModel.currencies.map<DropdownMenuItem<String>>((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Center(child: Text(currency)),
          );
        }).toList(),
      ),
    );
  }
}

class CurrencyModel {
  static const List<String> currencies = [
    'BRL', 'USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD', 'CHF', 'CNY', 'SEK',
    'NZD', 'MXN', 'SGD', 'HKD', 'NOK', 'KRW', 'TRY', 'RUB', 'INR', 'ZAR'
  ];
}