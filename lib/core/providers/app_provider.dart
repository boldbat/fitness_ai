import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppProvider extends ChangeNotifier {
  // Backend Configuration
  String? backendUrl = dotenv.env['BACKEND_URL'];

  AppProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (backendUrl == null) {
      print("Warning: BACKEND_URL environment variable is not set. "
          "Please configure your backend URL.");
    } else {
      print("Backend URL configured: $backendUrl");
      // You can add backend initialization logic here,
      // like connecting to a database or API client.
    }
  }

  // App-level state variables and methods will go here
}
