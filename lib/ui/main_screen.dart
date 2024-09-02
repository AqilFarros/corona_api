import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    this.username,
    this.password,
    this.firstName,
    this.lastName,
  });

  final String? username;
  final String? password;
  final String? firstName;
  final String? lastName;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.healing_outlined,
              color: Colors.white,
              size: 32,
            ),
            Text(
              "COVID-19",
              style: GoogleFonts.ubuntu(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
        elevation: 8,
        shadowColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              children: [
                PieChart(
                  PieChartData(
                    centerSpaceRadius: 5,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    sections: [
                      PieChartSectionData(
                          value: 35, color: Colors.purple, radius: 100),
                      PieChartSectionData(
                          value: 40, color: Colors.amber, radius: 100),
                      PieChartSectionData(
                          value: 55, color: Colors.green, radius: 100),
                      PieChartSectionData(
                          value: 70, color: Colors.orange, radius: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PieChatWidget extends StatelessWidget {
  const PieChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 5,
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        sections: [
          PieChartSectionData(value: 35, color: Colors.purple, radius: 100),
          PieChartSectionData(value: 40, color: Colors.amber, radius: 100),
          PieChartSectionData(value: 55, color: Colors.green, radius: 100),
          PieChartSectionData(value: 70, color: Colors.orange, radius: 100),
        ],
      ),
    );
  }
}
