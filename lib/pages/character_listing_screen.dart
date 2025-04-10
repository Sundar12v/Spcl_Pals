import 'package:flutter/material.dart';
import 'package:special_pals/models/character.dart';
import 'package:special_pals/styleguide.dart';
import 'package:special_pals/widgets/character_widget.dart';

class CharacterListingScreen extends StatefulWidget {
  const CharacterListingScreen({Key? key}) : super(key: key);

  @override
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false,
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Always dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFFF977C),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Hi, I'm Jack.", style: AppTheme.display1),
                      const TextSpan(text: "\n"),
                      TextSpan(text: "Meet Bevis! →", style: AppTheme.display2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return CharacterWidget(
                      character: characters[index],
                      pageController: _pageController,
                      currentPage: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
