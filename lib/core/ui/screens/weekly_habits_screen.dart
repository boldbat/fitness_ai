import 'package:flutter/material.dart';
import 'package:fitness_ai/core/ui/screens/push_notifications_screen.dart';

class WeeklyHabitsScreen extends StatefulWidget {
  const WeeklyHabitsScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyHabitsScreen> createState() => _WeeklyHabitsScreenState();
}

class _WeeklyHabitsScreenState extends State<WeeklyHabitsScreen> {
  /// Track which habit is currently selected (null if none selected).
  int? _selectedIndex;

  /// List of habits with emojis, titles, and descriptions.
  final List<Map<String, String>> _habits = [
    {
      'emoji': '🍳',
      'title': 'Eat more protein',
      'description':
          'Increasing your protein intake can help build muscle and keep you satisfied.'
    },
    {
      'emoji': '💧',
      'title': 'Drink more water',
      'description':
          'Staying hydrated throughout the day can help boost energy and flush out toxins.'
    },
    {
      'emoji': '🍑',
      'title': 'Eat more fruit',
      'description':
          'Fruits are packed with vitamins, minerals, and fiber essential for good health.'
    },
    {
      'emoji': '🥦',
      'title': 'Eat more vegetables',
      'description':
          'Vegetables are nutrient-dense, low in calories, and vital to a balanced diet.'
    },
    {
      'emoji': '✅',
      'title': 'Log a daily meal',
      'description':
          'Tracking at least one meal daily can help you become aware of your eating habits.'
    },
    {
      'emoji': '🍿',
      'title': 'Eat more fiber',
      'description':
          'Fiber supports healthy digestion and helps maintain a healthy gut.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Weekly Habits',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'What will be your habit this week?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You’ll focus on this one for the next 7 days.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 24),

          /// Build each habit option from the list
          for (int i = 0; i < _habits.length; i++)
            _buildHabitOption(
              index: i,
              emoji: _habits[i]['emoji'] ?? '',
              title: _habits[i]['title'] ?? '',
              description: _habits[i]['description'] ?? '',
            ),

          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                // If user wants none of these
                setState(() {
                  _selectedIndex = null;
                });
              },
              child: const Text(
                'None of these',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PushNotificationsScreen()),
            );
          },
          child: const Text('Next', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  /// Helper to build each habit item row with an emoji, title, and optional subtext.
  Widget _buildHabitOption({
    required int index,
    required String emoji,
    required String title,
    required String description,
  }) {
    final bool isSelected = (_selectedIndex == index);

    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle selection; if tapping again on the same item, deselect
          if (_selectedIndex == index) {
            _selectedIndex = null;
          } else {
            _selectedIndex = index;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Highlight if selected
          color: isSelected ? Colors.blueGrey[700] : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.blueAccent, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
