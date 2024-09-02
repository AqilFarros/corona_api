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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.healing_rounded,
              size: 128,
              color: Colors.red[700],
            ),
            Text(
              "Welcome back ${widget.username}",
              style: GoogleFonts.openSans(
                fontSize: 18.0,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              "Your password is ${widget.password}",
              style: GoogleFonts.openSans(
                fontSize: 18.0,
                letterSpacing: 2.0,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    padding: const EdgeInsets.all(20.0),
                    content: Text(
                      "HI ${widget.firstName} ${widget.lastName}",
                      style: GoogleFonts.openSans(),
                    ),
                    leading: const Icon(Icons.handshake),
                    backgroundColor: Colors.white70,
                    elevation: 5,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                        },
                        child: Text(
                          "Dismiss",
                          style: GoogleFonts.openSans(),
                        ),
                      )
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                elevation: 8,
              ),
              child: Text(
                'Click Me!!!',
                style: GoogleFonts.openSans(
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
