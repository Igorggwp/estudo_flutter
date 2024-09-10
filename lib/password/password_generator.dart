import 'dart:math';

class PasswordGenerator {
  final bool includeUppercase;
  final bool includeLowercase;
  final bool includeNumbers;
  final bool includeSpecialChars;
  final int length;

  PasswordGenerator({
    this.includeUppercase = true,
    this.includeLowercase = true,
    this.includeNumbers = true,
    this.includeSpecialChars = true,
    this.length = 12,
  });

  String generatePassword() {
    const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String specialChars = '!@#\$%&*()-_=+,.<>;:/?';

    String charPool = '';
    if (includeUppercase) charPool += uppercase;
    if (includeLowercase) charPool += lowercase;
    if (includeNumbers) charPool += numbers;
    if (includeSpecialChars) charPool += specialChars;

    if (charPool.isEmpty) {
      throw Exception('Nenhum tipo de caractere selecionado para gerar a senha.');
    }

    final random = Random.secure();
    return List.generate(length, (index) {
      final randomIndex = random.nextInt(charPool.length);
      return charPool[randomIndex];
    }).join();
  }
}