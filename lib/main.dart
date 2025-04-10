import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:special_pals/delayed_animation.dart';
import 'package:special_pals/pages/character_listing_screen.dart';
import 'intro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    const color = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFF977C),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40.0),
              AvatarGlow(
                glowRadiusFactor: 0.4, // Replace endRadius with this
                duration: Duration(seconds: 2),
                glowColor: Colors.white,
                repeat: true,
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/redpanda.png'),
                    backgroundColor: Colors.grey[100],
                    radius: 50.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DelayedAnimation(
                child: const Text(
                  "Hi There!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    fontFamily: 'Nunito',
                    color: color,
                  ),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: const Text(
                  "I'm Jack",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    fontFamily: 'Nunito',
                    color: color,
                  ),
                ),
                delay: delayedAmount + 2000,
              ),
              const SizedBox(height: 75.0),
              DelayedAnimation(
                child: const Text(
                  "Your New Personal",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PTSans',
                    color: color,
                  ),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: const Text(
                  "Learning Companion",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PTSans',
                    color: color,
                  ),
                ),
                delay: delayedAmount + 3000,
              ),
              const SizedBox(height: 100.0),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI(context),
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              const SizedBox(height: 50.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CharacterListingScreen()));
                },
                child: DelayedAnimation(
                  child: const Text(
                    "LEARN MORE ABOUT ME",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  delay: delayedAmount + 5000,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedButtonUI(BuildContext context) {
    return Container(
      height: 60,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => IntroPage()));
        },
        child: const Center(
          child: Text(
            'Hi Jack!',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
