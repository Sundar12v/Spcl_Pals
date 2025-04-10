import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:audioplayers/audioplayers.dart';

class ElephantPage extends StatefulWidget {
  @override
  _ElephantPageState createState() => _ElephantPageState();
}

class _ElephantPageState extends State<ElephantPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Widget> steps = [
    buildFactCard('Elephants are the world’s \n largest land animals!'),
    buildFactCard('African elephants have large ears \n shaped like the continent of Africa!'),
    buildFactCard('There are two species: \n African and Asian elephants.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, size: 30, color: Colors.black54),
                ),
                const Spacer(),
                const LikeButton(size: 30),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Elephant',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Elephant moms usually give birth\n     to just one calf at a time.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset('assets/elephant.png', height: 230, width: 400),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    await _audioPlayer.play(AssetSource('elephant.mp3'));
                  },
                  child: Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.music_note, color: Colors.white, size: 30),
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  'Play Sound',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'NunitoSans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'An elephant makes a trumpet sound.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Nunito',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(350, 170)),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return steps[index];
                },
                itemCount: steps.length,
                itemHeight: 170,
                itemWidth: 350,
                layout: SwiperLayout.TINDER,
                control: SwiperControl(color: Colors.black),
                pagination: const SwiperPagination(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildFactCard(String text) {
  return Container(
    height: 170,
    width: 350,
    decoration: BoxDecoration(
      color: Colors.deepOrangeAccent[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'NunitoSans',
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
