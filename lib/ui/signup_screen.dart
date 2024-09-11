import 'package:corona_api/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  bool isSignedIn = false;

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
              "Make An Account",
              style: GoogleFonts.ubuntu(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'username',
                      labelStyle: GoogleFonts.openSans(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: GoogleFonts.openSans(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'password',
                      labelStyle: GoogleFonts.openSans(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: GoogleFonts.openSans(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: firstName,
                          decoration: InputDecoration(
                            labelText: 'first name',
                            labelStyle: GoogleFonts.openSans(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: GoogleFonts.openSans(),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: lastName,
                          decoration: InputDecoration(
                            labelText: 'last name',
                            labelStyle: GoogleFonts.openSans(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: GoogleFonts.openSans(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/login",
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          "Already Have An Account?",
                          style: GoogleFonts.openSans(
                            color: Colors.blue[300],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (usernameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              firstName.text.isEmpty ||
                              lastName.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "All Field Must Be Filled",
                                  style: GoogleFonts.openSans(),
                                ),
                              ),
                            );
                          } else if (passwordController.text.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "The Password Field Must Be At Least 8 Characters",
                                  style: GoogleFonts.openSans(),
                                ),
                              ),
                            );
                          } else {
                            isSignedIn = true;

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                ),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(5.0),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.red[600]),
                        ),
                        child: Text(
                          "Signup",
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
