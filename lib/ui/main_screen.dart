import 'package:carousel_slider/carousel_slider.dart';
import 'package:corona_api/model/hoax.dart';
import 'package:corona_api/model/news.dart';
import 'package:corona_api/service/api_service.dart';
import 'package:corona_api/model/hospital.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
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
  final Future<List<Hospital>?> hospital = ApiService().getHospital();
  final List<String> imgList = [
    "https://i.pinimg.com/564x/e3/f2/4a/e3f24ae796cfcab249792bc3d670eed8.jpg",
    "https://i.pinimg.com/564x/62/c0/ef/62c0efdb30f39b66adbf239a5bb6a491.jpg",
    "https://i.pinimg.com/564x/16/04/15/1604155d80da827c6469e8f79e6a8481.jpg",
    "https://i.pinimg.com/564x/5e/bb/8b/5ebb8bbb905c7ae43b7f34cdbe1d19da.jpg",
    "https://i.pinimg.com/564x/38/79/a2/3879a25e21554f9fba02cc7c4b7ecb35.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  DashboardWidget(
                    username: widget.username.toString(),
                    password: widget.password.toString(),
                    firstName: widget.firstName,
                    lastname: widget.lastName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleWidget(
                    icon: Icon(
                      Icons.stacked_line_chart_rounded,
                      color: Colors.red[600],
                      size: 40,
                    ),
                    title: "Latest Covid-19 Stats",
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
                        return PieChatWidget(
                          number: snapshot.data!["numbers"],
                        );
                      }
                    },
                  ),
                  TitleWidget(
                    icon: Icon(
                      Icons.health_and_safety,
                      color: Colors.red[600],
                      size: 40,
                    ),
                    title: "The Hospitals",
                  ),
                  FutureBuilder(
                    future: hospital,
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
                        List<int> numbers = [];
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          numbers.add(i);
                        }
                        numbers.shuffle();

                        return CarouselSlider.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext builder, int index,
                              int pageViewIndex) {
                            return CarouselWidget(
                              img: imgList[index],
                              text: snapshot.data![numbers[index]].name
                                  .toString(),
                              location: snapshot.data![numbers[index]].province
                                  .toString(),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                        );
                      }
                    },
                  ),
                  TabBarWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({
    super.key,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastname,
  });

  final String username;
  final String password;
  final firstName;
  final lastname;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "https://ui-avatars.com/api/?background=random&name=${firstName != null ? '$firstName+$lastname' : username}",
                ),
                radius: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    "Welcome Back $username \nYour Password is ...",
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
                    "Your password is $password \nKeep it secret!",
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
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            style: GoogleFonts.ubuntu(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
    return Column(
      children: [
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
          ),
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
      ],
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.img,
    required this.text,
    required this.location,
  });

  final String img;
  final String text;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(img, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.red[600],
                  ),
                  Text(
                    location,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  final Future<List<News>?> news = ApiService().getNews();
  final Future<List<Hoax>?> hoax = ApiService().getHoax();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: Colors.red[600],
          labelColor: Colors.red[600],
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              child: Text(
                "News",
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Hoaxes",
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 300,
          child: TabBarView(
            children: [
              FutureBuilder(
                future: news,
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
                      child: Text("News is not found!"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: double.infinity,
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
                                snapshot.data![index].title.toString(),
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                snapshot.data![index].timestamp.toString(),
                                style: GoogleFonts.openSans(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              FutureBuilder(
                future: hoax,
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
                      child: Text("Hoaxes is not found!"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: double.infinity,
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
                                snapshot.data![index].title.toString(),
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                snapshot.data![index].timestamp.toString(),
                                style: GoogleFonts.openSans(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
