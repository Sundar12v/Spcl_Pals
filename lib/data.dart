import 'package:flutter/material.dart';

class PageModel {
  final String imageUrl;
  final String title;
  final String body;
  final List<Color> titleGradient;

  PageModel({
    required this.imageUrl,
    required this.title,
    required this.body,
    required this.titleGradient,
  });
}

List<List<Color>> gradients = [
  [Colors.white, Colors.white70],
  [Colors.white, Colors.white70],
  [Colors.white, Colors.white70],
];

final List<PageModel> pageList = [
  PageModel(
    imageUrl: "assets/Learn.png",
    title: "Learn",
    body: "EXPERIENCE THE JOY OF LEARNING",
    titleGradient: gradients[0],
  ),
  PageModel(
    imageUrl: "assets/dream.jpg",
    title: "Draw",
    body: "FEEL THE MAGIC OF DRAWING",
    titleGradient: gradients[1],
  ),
  PageModel(
    imageUrl: "assets/draw.jpg",
    title: "Stories",
    body: "LET'S READ SOME STORIES",
    titleGradient: gradients[2],
  ),
];
