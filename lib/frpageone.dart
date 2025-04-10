import 'package:flutter/material.dart';
import 'lion.dart';
import 'toucan.dart';
import 'armadillo.dart';

class FronePage extends StatefulWidget {
  @override
  _FronePageState createState() => _FronePageState();
}

class _FronePageState extends State<FronePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fr1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 14),
              Text(
                'Tap us to know more.',
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  color: const Color.fromARGB(229, 255, 255, 255), // Replaces withOpacity(0.9)
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 58),

              // Toucan
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ToucanPage()));
                },
                child: Image.asset('assets/toucan.png', height: 140),
              ),
              const Text(
                'Toucan',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 74),

              // Lion
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LionPage()));
                },
                child: Image.asset('assets/lion.png', height: 250, width: 420),
              ),
              const Text(
                'Lion',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 1),

              // Armadillo
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ArmadilloPage()));
                  },
                  child: Image.asset('assets/armadillo.png', height: 118),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 46),
                    child: Text(
                      'Armadillo',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      'Swipe -->',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
