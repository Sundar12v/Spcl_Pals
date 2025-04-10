import 'package:flutter/material.dart';
import 'data.dart';
import 'page_indicator.dart';
import 'dashboard.dart';

class JackPage extends StatefulWidget {
  @override
  _JackPageState createState() => _JackPageState();
}

class _JackPageState extends State<JackPage> with TickerProviderStateMixin {
  late PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  late AnimationController animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentPage);
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF485563), Color(0xFF29323C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFDF4161),
        body: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  lastPage = currentPage == pageList.length - 1;
                  lastPage
                      ? animationController.forward()
                      : animationController.reset();
                });
              },
              itemBuilder: (context, index) {
                var page = pageList[index];
                var y = 1.0;

                if (_controller.position.haveDimensions) {
                  final delta = _controller.page! - index;
                  y = 1 - delta.abs().clamp(0.0, 1.0);
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(page.imageUrl),
                    const SizedBox(height: 3),
                    Container(
                      margin: const EdgeInsets.only(left: 12.0),
                      height: 120.0,
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: .10,
                            child: GradientText(
                              text: page.title,
                              gradient: LinearGradient(colors: page.titleGradient),
                              style: const TextStyle(
                                fontSize: 85.0,
                                fontFamily: "Nunito",
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 22.0),
                            child: GradientText(
                              text: page.title,
                              gradient: LinearGradient(colors: page.titleGradient),
                              style: const TextStyle(
                                fontSize: 60.0,
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 34.0, top: 12.0),
                      child: Transform(
                        transform: Matrix4.translationValues(0, 50.0 * (1 - y), 0),
                        child: Text(
                          page.body,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: "NunitoSans",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              left: 30.0,
              bottom: 55.0,
              child: SizedBox(
                width: 160.0,
                child: PageIndicator(currentPage, pageList.length),
              ),
            ),
            Positioned(
              right: 30.0,
              bottom: 30.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: lastPage
                    ? FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.arrow_forward, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardPage()),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Custom GradientText Widget (you can move this to a separate file)
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    Key? key,
    required this.text,
    required this.gradient,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
