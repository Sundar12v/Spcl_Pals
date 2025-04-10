import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ColorGameOne extends StatefulWidget {
  const ColorGameOne({Key? key}) : super(key: key);

  @override
  ColorGameOneState createState() => ColorGameOneState();
}

class ColorGameOneState extends State<ColorGameOne> {
  final Map<String, bool> score = {};

  final Map<String, Color> choices = {
    '🌰': Colors.brown,
    '🌻': Colors.yellow,
    '🌷': Colors.pinkAccent,
    '🌵': Colors.green,
    '🌹': Colors.red,
  };

  int seed = 0;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '            Score ${score.length} / 5',
          style: const TextStyle(
            fontSize: 22,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.purpleAccent[700],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent[700],
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
            children: choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
              ..shuffle(Random(seed)),
          )
        ],
      ),
    );
  }

  Widget _buildDragTarget(String emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (score[emoji] == true) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              color: Colors.transparent,
              child: const Text(
                'Correct!',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              alignment: Alignment.center,
              height: 80,
              width: 140,
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

      // ✅ Fixed: Use onWillAcceptWithDetails instead of onWillAccept
      onWillAcceptWithDetails: (DragTargetDetails<String> details) {
        return details.data == emoji;
      },

      // ✅ Fixed: Use onAcceptWithDetails instead of onAccept
      onAcceptWithDetails: (DragTargetDetails<String> details) async {
        setState(() {
          score[emoji] = true;
        });
        await _audioPlayer.play(AssetSource('Bell.mp3'));
      },
    );
  }
}

class Emoji extends StatelessWidget {
  const Emoji({Key? key, required this.emoji}) : super(key: key);

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
