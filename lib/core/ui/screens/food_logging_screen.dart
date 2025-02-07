import 'package:flutter/material.dart';

class FoodLoggingScreen extends StatelessWidget {
  const FoodLoggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // Added container for background color
              color: Colors.black, // Black background for the card content
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Log Your Meal',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.blue, // Blue title
                        ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(
                        color: Colors.white), // White text color
                    decoration: InputDecoration(
                      hintText: 'Search for food or enter a meal',
                      hintStyle:
                          TextStyle(color: Colors.grey[600]), // Grey hint text
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue), // Blue border
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Blue border when enabled
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Blue border when focused
                      ),
                      prefixIcon: const Icon(Icons.search,
                          color: Colors.blue), // Blue search icon
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement food logging logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Blue button background
                      foregroundColor: Colors.white, // White button text
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Log Food'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
