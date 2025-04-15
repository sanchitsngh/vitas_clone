import 'package:flutter/services.dart';

class USNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String newText = '';
    if (digitsOnly.length >= 1) {
      newText += '(${digitsOnly.substring(0, digitsOnly.length.clamp(0, 3))}';
    }
    if (digitsOnly.length > 3) {
      newText += ')-(${digitsOnly.substring(3, digitsOnly.length.clamp(3, 6))}';
    }
     if (digitsOnly.length >= 7) {
      newText += ')-(${digitsOnly.substring(6, digitsOnly.length.clamp(6, 10))})';
    } else if (digitsOnly.length > 6) {
      newText += ')'; // Close the last bracket if not yet 10 digits
    }


    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
