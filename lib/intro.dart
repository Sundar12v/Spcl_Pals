import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'jack.dart';
import 'dashboard.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF977C),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80.0),
            Row(
              children: <Widget>[
                const SizedBox(width: 40),
                AvatarGlow(
                  glowColor: Colors.white,
                  glowRadiusFactor: 0.4,
                  duration: const Duration(seconds: 2),
                  repeat: true,
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundImage: const AssetImage('assets/redpanda.png'),
                      backgroundColor: Colors.grey[100],
                      radius: 50.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Row(
              children: <Widget>[
                SizedBox(width: 42),
                Text(
                  "Nice to meet you!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Row(
              children: <Widget>[
                SizedBox(width: 42),
                Text(
                  "What do they call you by?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'Nunito',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              height: 80,
              width: 330.0,
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'They call me..',
                  hintStyle: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF977C)),
                  ),
                ),
                cursorColor: Colors.white,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 25.0,
                  height: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 200),
            Container(
              height: 60,
              width: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JackPage()));
                },
                child: const Center(
                  child: Text(
                    'Take a tour',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
              },
              child: const Text(
                "SKIP ANYWAY",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
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
