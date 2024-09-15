import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  _CepPageState createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  final TextEditingController _cepController = TextEditingController();
  String _resultado = '';

  void _buscarEndereco() async {
    String cep = _cepController.text;

    if (cep.isEmpty || cep.length != 8 || !RegExp(r'^\d+$').hasMatch(cep)) {
      setState(() {
        _resultado = 'CEP inválido. Certifique-se de que contém 8 dígitos numéricos.';
      });
      return;
    }

    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> dados = json.decode(response.body);
        if (dados.containsKey('erro')) {
          setState(() {
            _resultado = 'CEP não encontrado.';
          });
        } else {
          setState(() {
            _resultado = 'Endereço: ${dados['logradouro']}, Bairro: ${dados['bairro']}, Localidade: ${dados['localidade']}';
          });
        }
      } else {
        setState(() {
          _resultado = 'Erro ao consultar o CEP. Status: ${response.statusCode}.';
        });
      }
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao conectar ao serviço. Verifique sua conexão e tente novamente.';
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: const Text('Consulta Via CEP' ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Digite o CEP: ',
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _buscarEndereco,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}