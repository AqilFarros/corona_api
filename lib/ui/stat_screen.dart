import 'package:corona_api/service/api_service.dart';
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
                        height: 650,
                        child: ListView.builder(
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
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[600],
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.map_outlined,
                                        color: Colors.red[600],
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!["regions"][index]["number"]["infected"]
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
                                      Icon(
                                        Icons.phone,
                                        color: Colors.red[600],
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data!["regions"][index]["number"]["infected"]
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
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red[600],
                                        size: 24,
                                      ),
                                      Text(
                                        snapshot.data![index].province
                                            .toString(),
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
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