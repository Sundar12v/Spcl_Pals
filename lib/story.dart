import 'package:flutter/material.dart';
import 'storyone.dart';
import 'storytwo.dart';
import 'storythree.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: <Widget>[
          // Top Section with Title and Image
          Container(
            width: double.infinity,
            height: 300,
            color: const Color(0xFFFF585D),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35),
                const Text(
                  'Stories',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'LoveYaLikeASister',
                    fontSize: 46,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/f.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Story 1 Card
          buildStoryCard(
            title: 'The Boatman',
            imagePath: 'assets/s1.png',
            backgroundColor: Colors.deepOrangeAccent[100]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoryOne()),
              );
            },
            imageSize: 102,
          ),

          const SizedBox(height: 40),

          // Story 2 Card
          buildStoryCard(
            title: 'The Tomb',
            imagePath: 'assets/s2.png',
            backgroundColor: Colors.blue[400]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoryTwo()),
              );
            },
            imageSize: 100,
          ),

          const SizedBox(height: 40),

          // Story 3 Card
          buildStoryCard(
            title: 'Grasslands',
            imagePath: 'assets/s3.png',
            backgroundColor: Colors.greenAccent[400]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoryThree()),
              );
            },
            imageSize: 100,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildStoryCard({
    required String title,
    required String imagePath,
    required Color backgroundColor,
    required VoidCallback onTap,
    required double imageSize,
  }) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: backgroundColor,
          width: 350,
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  color: Colors.white,
                  height: 110,
                  child: Image.asset(imagePath, height: imageSize),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'LoveYaLikeASister',
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
