import 'package:corona_api/service/api_service.dart';
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
  final Future<Map?> stats = ApiService().getStat();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://ui-avatars.com/api/?background=random&name=${widget.firstName != null ? '${widget.firstName}+${widget.lastName}' : widget.username}",
                            ),
                            radius: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "Welcome Back ${widget.username} \nYour Password is ...",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              padding: const EdgeInsets.all(20.0),
                              content: Text(
                                "Your password is ${widget.password} \nKeep it secret!",
                                style: GoogleFonts.openSans(),
                              ),
                              leading: const Icon(Icons.safety_check_sharp),
                              backgroundColor: Colors.white,
                              elevation: 5,
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  },
                                  child: Text(
                                    "Dismiss",
                                    style: GoogleFonts.openSans(
                                      color: Colors.red[600],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                        ),
                        icon: Icon(
                          Icons.question_mark,
                          color: Colors.red[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stacked_line_chart_rounded,
                      color: Colors.red[600],
                      size: 40,
                    ),
                    Text(
                      "Latest Covid-19 Stats",
                      style: GoogleFonts.ubuntu(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
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
                        child: Text("Stats is not found!"),
                      );
                    } else {
                      return SizedBox(
                        width: 230,
                        height: 230,
                        child: PieChatWidget(
                          number: snapshot.data!["numbers"],
                        ),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.red[900],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Infected",
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.green[900],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Recovered",
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Fatal",
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: Colors.red[600],
                        size: 40,
                      ),
                      Text(
                        "The Hospitals",
                        style: GoogleFonts.ubuntu(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
  const PieChatWidget({
    super.key,
    this.number,
  });

  final Map? number;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 5,
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 2,
        sections: [
          PieChartSectionData(
            value: number?["fatal"] + 0.00,
            color: Colors.black,
            radius: 100,
            title: '',
          ),
          PieChartSectionData(
            value: number?["infected"] + 0.00,
            color: Colors.red[900],
            radius: 100,
            titleStyle: GoogleFonts.ubuntu(color: Colors.white),
          ),
          PieChartSectionData(
            value: number?["recovered"] + 0.00,
            color: Colors.green[900],
            radius: 100,
            titleStyle: GoogleFonts.ubuntu(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
