/*
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'glucose.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(), // Main screen with swipe functionality
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          HealthDashboard(), // Your main dashboard
          GlucoseStatsPage(), // Your glucose page
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HealthDashboard(),
    GlucoseStatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBar.item(
            icon: Icon(Icons.dashboard),
            label: 'Health Dashboard',
          ),
          BottomNavigationBar.item(
            icon: Icon(Icons.analytics),
            label: 'Glucose Stats',
          ),
        ],
      ),
    );
  }
}

// Important: Import the health dashboard classes here
// The code below is a placeholder - you should actually import the file containing the HealthDashboard class

class HealthDashboard extends StatefulWidget {
  const HealthDashboard({super.key});

  @override
  State<HealthDashboard> createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard> {
  // Create a single controller to manage all sections
  final SectionController _sectionController = SectionController();

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Body Vitals Section
              ExpandableSection(
                id: 'body_vitals',
                title: 'Body Vitals',
                icon: Icons.monitor_heart,
                controller: _sectionController,
                children: [
                  HealthTile(
                    title: 'Body Mass Index',
                    value: '21.61',
                    subvalue: 'Normal',
                    icon: Icons.accessibility_new,
                    color: Colors.purple[400]!,
                  ),
                  const SizedBox(height: 8),
                  HealthTile(
                    title: 'Body Surface Area',
                    value: '1.69 (m²)',
                    icon: Icons.person_outline,
                    color: Colors.purple[400]!,
                  ),
                  // Add more health tiles here
                ],
              ),
              // Add more sections here
            ],
          ),
        ),
      ),
    );
  }
}

// IMPORTANT: This is a placeholder for the classes needed
// In a real app, you would import these classes from the health_dashboard.dart file
// The code below is just for demonstration purposes to make the main.dart file runnable

class SectionController extends ChangeNotifier {
  String? _expandedSectionId;

  String? get expandedSectionId => _expandedSectionId;

  void expandSection(String sectionId) {
    if (_expandedSectionId == sectionId) {
      _expandedSectionId = null;
    } else {
      _expandedSectionId = sectionId;
    }
    notifyListeners();
  }
}

class ExpandableSection extends StatefulWidget {
  final String id;
  final String title;
  final IconData icon;
  final List<Widget> children;
  final SectionController controller;

  const ExpandableSection({
    super.key,
    required this.id,
    required this.title,
    required this.icon,
    required this.children,
    required this.controller,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateExpandedState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateExpandedState);
    super.dispose();
  }

  void _updateExpandedState() {
    final newExpandedState = widget.controller.expandedSectionId == widget.id;
    if (newExpandedState != _isExpanded) {
      setState(() {
        _isExpanded = newExpandedState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.controller.expandSection(widget.id);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withAlpha(77),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? null : 0,
          child: AnimatedOpacity(
            opacity: _isExpanded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: _isExpanded ? widget.children : [],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HealthTile extends StatelessWidget {
  final String title;
  final String value;
  final String? subvalue;
  final String? secondValue;
  final String? secondSubvalue;
  final IconData icon;
  final Color color;

  const HealthTile({
    super.key,
    required this.title,
    required this.value,
    this.subvalue,
    this.secondValue,
    this.secondSubvalue,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(3),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: value == 'No data'
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                if (subvalue != null)
                  Text(
                    subvalue!,
                    style: TextStyle(
                      fontSize: 14,
                      color: subvalue == 'Normal'
                          ? Colors.orange
                          : Colors.grey[700],
                    ),
                  ),
                if (secondValue != null) ...[
                  const SizedBox(height: 8),
                  Text(secondValue!, style: const TextStyle(fontSize: 16)),
                  if (secondSubvalue != null)
                    Text(
                      secondSubvalue!,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for GlucoseStatsPage
class GlucoseStatsPage extends StatelessWidget {
  const GlucoseStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Statistics'),
        backgroundColor: const Color(0xFF0277BD),
      ),
      body: const Center(
        child: Text('Glucose Stats Page'),
      ),
    );
  }
}
