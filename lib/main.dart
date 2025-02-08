import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart'; // Existing import for IconsPlus
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart'; // <-- Make sure this import is present

import 'core/providers/app_provider.dart';
import 'core/ui/screens/activity_tracking_screen.dart'; // Dashboard
import 'core/ui/screens/diary_screen.dart'; // Diary
import 'core/ui/screens/scan_screen.dart'; // Scan
import 'core/ui/screens/plans_screen.dart'; // Plans
import 'core/ui/screens/chat_coach_screen.dart'; // More

import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  print('Dotenv loaded successfully: ${dotenv.isEveryDefined([
        'FIREBASE_API_KEY'
      ])}'); // Add this line for logging
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness AI - Assistant',
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
          secondary: const Color(0xFFFFA000),
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Removed 'const'
    ActivityTrackingScreen(), // Dashboard
    DiaryScreen(), // Diary
    ScanScreen(), // Scan
    PlansScreen(), // Plans
    ChatCoachScreen(), // More (Coach Screen used as 'More' for now)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness AI - Assistant'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.house_fill),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.book_fill),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(BootstrapIcons.calendar_check_fill),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
