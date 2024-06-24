// lib/radio_button_provider.dart
import 'package:flutter/foundation.dart';

class RadioButtonProvider with ChangeNotifier {
  String _selectedOption = '';

  String get selectedOption => _selectedOption;

  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}
