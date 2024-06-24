// lib/providers/country_provider.dart

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountryProvider with ChangeNotifier {
  String _selectedCountryCode = '+1'; // Default to US country code

  String get selectedCountryCode => _selectedCountryCode;

  void setCountryCode(String countryCode) {
    _selectedCountryCode = countryCode;
    notifyListeners();
  }
}
