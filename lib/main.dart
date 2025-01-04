import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Quiz App Home',
            style: TextStyle(fontSize: 30),
          ),
        ),
        backgroundColor: const Color.fromRGBO(184, 101, 113, 1),
      ),
      backgroundColor: const Color.fromRGBO(184, 101, 113, 1),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the quiz screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuizScreen()),
            );
          },
          child: const Text(
            'Start Quiz',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  // Example quiz questions
  final List<Map<String, Object>> _quizData = [
    {
      'question': 'What is the capital of Spain?',
      'options': ['Paris', 'London', 'Berlin', 'Madrid'],
      'answer': 'Madrid'
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'answer': '4'
    },
    {
      'question': 'What is 6 + 2?',
      'options': ['3', '4', '5', '8'],
      'answer': '8'
    },
    {
      'question': 'What is the capital of Somalia?',
      'options': ['Mogadishu', 'London', 'Berlin', 'Madrid'],
      'answer': 'Mogadishu'
    },
    {
      'question': 'Which planet is closest to the Sun?',
      'options': ['Earth', 'Mars', 'Venus', 'Mercury'],
      'answer': 'Mercury'
    },
    {
      'question': 'Who developed the theory of relativity?',
      'options': ['Newton', 'Einstein', 'Galileo', 'Curie'],
      'answer': 'Einstein'
    },
  ];

  void _answerQuestion(String selectedAnswer) {
    if (selectedAnswer == _quizData[_currentQuestionIndex]['answer']) {
      setState(() {
        _score++;
      });
    }

    // Wait for 1 second before moving to the next question
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _currentQuestionIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _quizData.length) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(184, 101, 113, 1),
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Quiz Completed',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(184, 101, 113, 1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You scored: $_score/${_quizData.length}',
                style: const TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to home screen when quiz is finished
                  Navigator.pop(context);
                },
                child: const Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Quiz App',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(184, 101, 113, 1),
      ),
      backgroundColor: const Color.fromRGBO(184, 101, 113, 1),

      // Background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Question Text
            Text(
              _quizData[_currentQuestionIndex]['question'] as String,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Answer Options
            ...(_quizData[_currentQuestionIndex]['options'] as List<String>)
                .map((option) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(option),
                        child: Text(option),
                      ),
                    )),

            // Show remaining question count
            const SizedBox(height: 90),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_quizData.length}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
