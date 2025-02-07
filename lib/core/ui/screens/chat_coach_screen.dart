import 'package:flutter/material.dart';

class ChatCoachScreen extends StatelessWidget {
  const ChatCoachScreen({super.key});

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
                    'Chat with Your AI Coach',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.blue, // Blue title
                        ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Start a conversation with your AI fitness coach here!',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white), // White text
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Get personalized advice and motivation to reach your fitness goals.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
