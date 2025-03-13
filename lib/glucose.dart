import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        /*title: 'Glucose Statistics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const GlucoseStatsPage(),*/
        );
  }
}

class GlucoseStatsPage extends StatelessWidget {
  const GlucoseStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // title: const Text('Glucose Statistics'),
      //backgroundColor: const Color(0xFF0277BD),
      //),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // First Section: Glucose Exposure (Stacked vertically)
              GlucoseExposureSection(),
              const SizedBox(height: 12),

              // Second Section: Glucose Ranges
              GlucoseRangesSection(),
              const SizedBox(height: 12),

              // Third Section: Glucose Variability
              GlucoseVariabilitySection(),
            ],
          ),
        ),
      ),
    );
  }
}

/// First Section - Glucose Exposure (Top Cards)
class GlucoseExposureSection extends StatelessWidget {
  const GlucoseExposureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GlucoseCard(
                title1: 'Avg Glucose',
                title2: 'mg/dL',
                value: '122',
                footnote: '88 - 116 *',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlucoseCard(
                title1: 'Glycemic',
                title2: 'Estimate',
                value: '5.8',
                footnote: '< 6*',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SectionLabel(text: 'Glucose Exposure'),
      ],
    );
  }
}

/// Second Section - Glucose Ranges (Middle Card)
class GlucoseRangesSection extends StatelessWidget {
  const GlucoseRangesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlucoseRangesCard(
          ranges: [
            GlucoseRange('Below 54 mg/dL', '1.49%'),
            GlucoseRange('Below 70 mg/dL', '8.81%'),
            GlucoseRange('In Target 70 to 180 mg/dL', '78.94%'),
            GlucoseRange('Above 180 mg/dL', '8.66%'),
            GlucoseRange('Above 250 mg/dL', '2.09%'),
          ],
        ),
        const SizedBox(height: 8),
        SectionLabel(text: 'Glucose Ranges'),
      ],
    );
  }
}

/// Third Section - Glucose Variability (Bottom Cards)
class GlucoseVariabilitySection extends StatelessWidget {
  const GlucoseVariabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GlucoseCard(
                title1: 'Coefficient',
                title2: 'of Variation',
                value: '39.39%',
                footnote: '19.25 *',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlucoseCard(
                title1: 'SD',
                title2: 'mg/dL',
                value: '48.05',
                footnote: '10 - 26 *',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SectionLabel(text: 'Glucose Variability'),
      ],
    );
  }
}

/// Glucose Card Widget (Used in Multiple Sections)
class GlucoseCard extends StatelessWidget {
  final String title1;
  final String title2;
  final String value;
  final String footnote;
  final Color valueColor;
  final Color backgroundColor;

  const GlucoseCard({
    super.key,
    required this.title1,
    required this.title2,
    required this.value,
    required this.footnote,
    required this.valueColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: backgroundColor,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  title2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  footnote,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glucose Ranges Widget
class GlucoseRangesCard extends StatelessWidget {
  final List<GlucoseRange> ranges;

  const GlucoseRangesCard({super.key, required this.ranges});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: ranges.map((range) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child:
                        Text(range.label, style: const TextStyle(fontSize: 14)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('.....................',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  Text(range.value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Simple Section Label Widget
class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold),
    );
  }
}

class GlucoseRange {
  final String label;
  final String value;

  GlucoseRange(this.label, this.value);
}
