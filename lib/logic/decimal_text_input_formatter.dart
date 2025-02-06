import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Allow only digits and one decimal point
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return oldValue; // Reject the change
    }

    // Prevent multiple decimal points
    if (text.contains('.') && text.indexOf('.') != text.lastIndexOf('.')) {
      return oldValue; // Reject extra decimals
    }

    // Limit to two decimal places
    if (text.contains('.')) {
      List<String> parts = text.split('.');
      if (parts.length > 1 && parts[1].length > 2) {
        return oldValue; // Reject input beyond two decimal places
      }
    }

    return newValue; // Accept valid input
  }
}