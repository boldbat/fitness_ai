import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitness_ai/core/ui/screens/weekly_habits_screen.dart';

class ActivityTrackingScreen extends StatelessWidget {
  const ActivityTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---------------------
              // 1) Top Header Section
              // ---------------------
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side: time + avatar
                    Row(
                      children: [
                        Text(
                          '18:33',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: const NetworkImage(
                            'https://via.placeholder.com/40x40.png?text=User',
                          ),
                        ),
                      ],
                    ),
                    // Right side: "Go Premium" + bell icon
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // Handle premium button press
                          },
                          child: Row(
                            children: const [
                              Text('Go Premium',
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(width: 4),
                              Icon(Icons.workspace_premium,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          color: Colors.white,
                          onPressed: () {
                            // Handle bell/notification press
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ---------------------------
              // 2) "myfitnesspal" Section
              // ---------------------------
              Container(
                width: double.infinity,
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      'myfitnesspal',
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Go Premium',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                alignment: Alignment.centerLeft,
                color: Colors.black,
                child: Text(
                  'Today',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              // -----------
              // 3) Calories
              // -----------
              _buildCaloriesCard(context),

              // ---------------
              // 4) HeartHealthy
              // ---------------
              _buildHeartHealthyCard(context),

              // Ad placeholder
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Banner Ad Placeholder (e.g. Binance)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),

              // "Choose your next habit"
              _buildHabitCard(context),

              // --------------------
              // 5) Steps & Exercise
              // --------------------
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(child: _buildStepsCard(context)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildExerciseCard(context)),
                  ],
                ),
              ),

              // ---------------
              // 6) Weight Chart
              // ---------------
              _buildWeightCard(context),

              // -----------
              // 7) Discover
              // -----------
              _buildDiscoverSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================================
  // CALORIES WIDGET
  // =============================================================================
  Widget _buildCaloriesCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Remaining = Goal - Food + Exercise',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: 0.8,
                      color: Colors.blue,
                      backgroundColor: Colors.grey,
                      strokeWidth: 8,
                    ),
                    const Center(
                      child: Text(
                        '3,260',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCalorieDetailRow('Base Goal', '3,090'),
                    _buildCalorieDetailRow('Food', '0'),
                    _buildCalorieDetailRow('Exercise', '170'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // =============================================================================
  // HEART HEALTHY WIDGET
  // =============================================================================
  Widget _buildHeartHealthyCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Heart Healthy',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          _buildNutrientRow('Fat', '0/-- mg'),
          _buildNutrientRow('Sodium', '0/-- mg'),
          _buildNutrientRow('Cholesterol', '0/-- mg'),
        ],
      ),
    );
  }

  Widget _buildNutrientRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // =============================================================================
  // WEIGHT CHART WIDGET
  // =============================================================================
  Widget _buildWeightCard(BuildContext context) {
    final List<FlSpot> spots = [
      FlSpot(0, 70),
      FlSpot(1, 70),
      FlSpot(2, 69),
      FlSpot(3, 68),
      FlSpot(4, 68),
      FlSpot(5, 67),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weight (Last 90 days)',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 2,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // STEPS WIDGET
  // =============================================================================
  Widget _buildStepsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Steps',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // optional custom size
                ),
          ),
          const SizedBox(height: 4),
          const Text(
            '11,252',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 4),
          const Text(
            'Goal: 10,000 steps',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // EXERCISE WIDGET
  // =============================================================================
  Widget _buildExerciseCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Exercise',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // optional custom size
                ),
          ),
          const SizedBox(height: 4),
          const Text(
            '170 cal',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 4),
          const Text(
            '00:00 hr',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // HABIT CARD
  // =============================================================================
  Widget _buildHabitCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Choose your next habit',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Big goals start with small habits.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const WeeklyHabitsScreen(),
              ),
            );
          },
          child: const Text('Start a habit'),
        ),
      ]),
    );
  }

  // =============================================================================
  // DISCOVER SECTION
  // =============================================================================
  Widget _buildDiscoverSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildDiscoverItem(
                  Icons.nightlight_round, 'Sleep', 'Eat right, sleep tight'),
              _buildDiscoverItem(
                  Icons.restaurant_menu, 'Recipes', 'Cook, eat, log, repeat'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildDiscoverItem(
                  Icons.fitness_center, 'Workouts', 'Sweating is self-care'),
              _buildDiscoverItem(
                  Icons.devices_other, 'Sync up', 'Link apps & devices'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverItem(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue[300], size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
