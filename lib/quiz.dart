import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dashboard.dart';

int finalScore = 0;
int questionNumber = 0;

final quiz = AnimalQuiz();

class AnimalQuiz {
  final images = ["li", "be", "ti", "ow", "ra"];

  final questions = [
    "This animal is the king of the jungle.",
    "_________ loves to eat honey.",
    "_________ has orange and\nblack stripes.",
    "\tA nocturnal animal with\nsome really big eyes.",
    "This animal has white fur.",
  ];

  final choices = [
    ["Tiger", "Sheep", "Lion", "Monkey"],
    ["Cat", "Elephant", "Bear", "Horse"],
    ["Mouse", "Tiger", "Elephant", "Donkey"],
    ["Spider", "Cow", "Hawk", "Owl"],
    ["Tiger", "Zebra", "Giraffe", "Rabbit"],
  ];

  final correctAnswers = [
    "Lion",
    "Bear",
    "Tiger",
    "Owl",
    "Rabbit",
  ];
}

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuizState();
}

class QuizState extends State<Quiz> {
  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Summary(score: finalScore),
          ),
        );
      } else {
        questionNumber++;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      finalScore = 0;
      questionNumber = 0;
      Navigator.pop(context);
    });
  }

  Widget answerButton(String choiceText, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: MaterialButton(
        height: 50,
        minWidth: 120,
        color: Colors.blue[600],
        onPressed: () {
          if (quiz.choices[questionNumber][index] ==
              quiz.correctAnswers[questionNumber]) {
            finalScore++;
          }
          updateQuestion();
        },
        child: Text(
          choiceText,
          style: const TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Score & Question
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Q${questionNumber + 1} of ${quiz.questions.length}",
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Column(
                    children: [
                      AvatarGlow(
                        glowRadiusFactor: 0.4,
                        duration: const Duration(seconds: 2),
                        glowColor: Colors.white,
                        repeat: true,
                        child: Material(
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/redpanda.png'),
                            backgroundColor: Colors.grey[100],
                            radius: 30.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Score: $finalScore",
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 16),

              // Image
              Image.asset(
                "assets/${quiz.images[questionNumber]}.jpg",
                height: 280,
              ),

              const SizedBox(height: 16),

              // Question
              Text(
                quiz.questions[questionNumber],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 20),

              // Answer Buttons
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      answerButton(quiz.choices[questionNumber][0], 0),
                      answerButton(quiz.choices[questionNumber][1], 1),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      answerButton(quiz.choices[questionNumber][2], 2),
                      answerButton(quiz.choices[questionNumber][3], 3),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Quit Button
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: MaterialButton(
                  height: 50,
                  minWidth: 240,
                  color: Colors.red,
                  onPressed: resetQuiz,
                  child: const Text(
                    "Quit",
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 20,
                      color: Colors.white,
                    ),
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

class Summary extends StatelessWidget {
  final int score;
  const Summary({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Final Score: $score",
                style: const TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 40),

              // Reset Button
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: MaterialButton(
                  height: 50,
                  color: Colors.red,
                  onPressed: () {
                    questionNumber = 0;
                    finalScore = 0;
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Reset Quiz",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Dashboard Button
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: MaterialButton(
                  height: 50,
                  color: Colors.green,
                  onPressed: () {
                    questionNumber = 0;
                    finalScore = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      color: Colors.white,
                    ),
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
