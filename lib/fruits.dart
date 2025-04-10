import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class ColorGame extends StatefulWidget {
  ColorGame({Key? key}) : super(key: key);

  @override
  ColorGameState createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  final Map<String, bool> score = {};

  final Map<String, Color> choices = {
    '🍏': Colors.green,
    '🍋': Colors.yellow,
    '🍒': Colors.red,
    '🍇': Colors.purple,
    '🥥': Colors.brown,
    '🥭': Colors.orange,
  };

  int seed = 0;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '            Score ${score.length} / 6',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[400],
        child: Icon(Icons.refresh),
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
                childWhenDragging: Emoji(emoji: ''),
              );
            }).toList(),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices.keys
                .map((emoji) => _buildDragTarget(emoji))
                .toList()
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
              child: Text(
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

      // ✅ Updated: Replaced deprecated onWillAccept
      onWillAcceptWithDetails: (DragTargetDetails<String> details) {
        return details.data == emoji;
      },

      // ✅ Updated: Replaced deprecated onAccept
      onAcceptWithDetails: (DragTargetDetails<String> details) async {
        if (details.data == emoji) {
          setState(() {
            score[emoji] = true;
          });
          await _audioPlayer.stop();
          await _audioPlayer.play(AssetSource('Bell.mp3'));
        }
      },

      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  final String emoji;

  const Emoji({Key? key, required this.emoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 90,
        padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
