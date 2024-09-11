import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:corona_api/service/api_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  final Future<Map?> stats = ApiService().getStat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (router) => false,
                );
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
        elevation: 8,
        shadowColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Center(
            child: Column(
              children: [
                FutureBuilder(
                  future: stats,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Users is not found!"),
                      );
                    } else {
                      return SizedBox(
                        width: 400,
                        height: 600,
                        child: ListView.builder(
                          itemCount: snapshot.data!["regions"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!["regions"][index]["name"],
                                    style: GoogleFonts.openSans(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[600],
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Infected:",
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red[900],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!["regions"][index]
                                                  ["numbers"]["infected"]
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Recovered:",
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!["regions"][index]
                                                  ["numbers"]["recovered"]
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Fatal:",
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!["regions"][index]
                                                  ["numbers"]["fatal"]
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.info,
                                            animType: AnimType.scale,
                                            dismissOnTouchOutside: true,
                                            dismissOnBackKeyPress: true,
                                            showCloseIcon: true,
                                            btnOkColor: Colors.red.shade600,
                                            btnOkOnPress: () {},
                                            body: Column(
                                              children: [
                                                Text(
                                                  "${snapshot.data!["regions"][index]["name"]} stats",
                                                  style: GoogleFonts.ubuntu(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 230,
                                                  height: 230,
                                                  child: PieChart(
                                                    PieChartData(
                                                      centerSpaceRadius: 5,
                                                      borderData: FlBorderData(
                                                        show: false,
                                                      ),
                                                      sectionsSpace: 2,
                                                      sections: [
                                                        PieChartSectionData(
                                                          value: snapshot.data![
                                                                              "regions"]
                                                                          [
                                                                          index]
                                                                      [
                                                                      "numbers"]
                                                                  ["fatal"] +
                                                              0.00,
                                                          color: Colors.black,
                                                          radius: 100,
                                                          title: '',
                                                        ),
                                                        PieChartSectionData(
                                                          value: snapshot.data![
                                                                              "regions"]
                                                                          [
                                                                          index]
                                                                      [
                                                                      "numbers"]
                                                                  ["infected"] +
                                                              0.00,
                                                          color:
                                                              Colors.red[900],
                                                          radius: 100,
                                                          titleStyle:
                                                              GoogleFonts.ubuntu(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        PieChartSectionData(
                                                          value: snapshot.data![
                                                                              "regions"]
                                                                          [
                                                                          index]
                                                                      [
                                                                      "numbers"]
                                                                  [
                                                                  "recovered"] +
                                                              0.00,
                                                          color:
                                                              Colors.green[900],
                                                          radius: 100,
                                                          titleStyle:
                                                              GoogleFonts.ubuntu(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).show();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red[600],
                                        ),
                                        child: Text(
                                          "Show Chart",
                                          style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
