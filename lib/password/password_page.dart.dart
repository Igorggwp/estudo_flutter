import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'password_generator.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeNumbers = true;
  bool includeSpecialChars = true;
  double length = 12;
  String password = '';
  String complexity = '';
  Color complexityColor = Colors.red;

  void generatePassword() {
    final passwordGenerator = PasswordGenerator(
      includeUppercase: includeUppercase,
      includeLowercase: includeLowercase,
      includeNumbers: includeNumbers,
      includeSpecialChars: includeSpecialChars,
      length: length.round(),
    );
    setState(() {
      password = passwordGenerator.generatePassword();
      complexity = evaluatePasswordComplexity(password);
    });
  }

  String evaluatePasswordComplexity(String password) {
    int score = 0;

    if (password.length >= 6) score++;
    if (password.length >= 10) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%&*()-_=+,.<>;:/?]').hasMatch(password)) score++;

    if (score <= 3) {
      complexityColor = Colors.red;
      return 'Senha fraca';
    } else if (score == 4 || score == 5) {
      complexityColor = Colors.yellow;
      return 'Senha média';
    } else if (score == 6) {
      complexityColor = Colors.green;
      return 'Senha forte';
    }
    complexityColor = Colors.red;
    return 'Senha fraca';
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          'Gerador de Senha',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://cdn.pixabay.com/photo/2013/04/01/09/02/read-only-98443_1280.png",
              width: 200,
              height: 200,
            ),
            const Text(
              'Gerador automático de senha',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Aqui você escolhe como deseja gerar sua senha',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: includeUppercase,
                  onChanged: (value) {
                    setState(() {
                      includeUppercase = value!;
                    });
                  },
                ),
                const Text('[A-Z]'),
                Checkbox(
                  value: includeLowercase,
                  onChanged: (value) {
                    setState(() {
                      includeLowercase = value!;
                    });
                  },
                ),
                const Text('[a-z]'),
                Checkbox(
                  value: includeNumbers,
                  onChanged: (value) {
                    setState(() {
                      includeNumbers = value!;
                    });
                  },
                ),
                const Text('[0-9]'),
                Checkbox(
                  value: includeSpecialChars,
                  onChanged: (value) {
                    setState(() {
                      includeSpecialChars = value!;
                    });
                  },
                ),
                const Text('[@#!]'),
              ],
            ),
            const SizedBox(height: 20),
            Slider(
              value: length,
              min: 6,
              max: 50,
              divisions: 44,
              label: length.round().toString(),
              onChanged: (value) {
                setState(() {
                  length = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: generatePassword,
              child: const Text('Gerar senha'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  password,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Text(
              complexity,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: complexityColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: copyToClipboard,
              child: const Text('Copiar senha'),
            ),
          ],
        ),
      ),
    );
  }
}