import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class ColorGameTwo extends StatefulWidget {
  const ColorGameTwo({super.key});

  @override
  ColorGameTwoState createState() => ColorGameTwoState();
}

class ColorGameTwoState extends State<ColorGameTwo> {
  final Map<String, bool> score = {};

  final Map<String, Color?> choices = {
    '🦁': Colors.yellow[600],
    '🐯': Colors.orangeAccent[700],
    '🐷': Colors.pink[100],
    '🐻': Colors.brown,
    '🐸': Colors.green,
  };

  int seed = 0;

  final AudioPlayer _player = AudioPlayer();

  Future<void> playCorrectSound() async {
    await _player.play(AssetSource('Bell.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '            Score ${score.length} / 5',
          style: const TextStyle(
              fontSize: 22, fontFamily: 'Nunito', fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((emoji) {
              return Draggable<String>(
                data: emoji,
                child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                feedback: Emoji(emoji: emoji),
                childWhenDragging: const Emoji(emoji: ''),
              );
            }).toList(),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                  ..shuffle(Random(seed)),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(String emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List<dynamic> rejected) {
        if (score[emoji] == true) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              height: 80,
              width: 140,
              child: const Text(
                'Correct!',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              color: choices[emoji],
              height: 80,
              width: 150,
            ),
          );
        }
      },
      onWillAcceptWithDetails: (DragTargetDetails<String> details) {
        return details.data == emoji;
      },
      onAcceptWithDetails: (DragTargetDetails<String> details) {
        setState(() {
          score[emoji] = true;
        });
        playCorrectSound();
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  const Emoji({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 90,
            padding: const EdgeInsets.all(10),
            child: Text(
              emoji,
              style: const TextStyle(color: Colors.black, fontSize: 50),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
