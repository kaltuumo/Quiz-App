import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showCheckIcon = false;
  bool _showCloseIcon = false;

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
        _showCheckIcon = true;
        _showCloseIcon = false;
      });
    } else {
      setState(() {
        _showCheckIcon = false;
        _showCloseIcon = true;
      });
    }

    // Wait for 1 second before moving to the next question
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _currentQuestionIndex++;
        _showCheckIcon = false;
        _showCloseIcon = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _quizData.length) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(184, 101, 113, 1),
        appBar: AppBar(
          title: Center(
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
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                  });
                },
                child: Text(
                  'Restart Quiz',
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
        title: Center(
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Question Text
            Text(
              _quizData[_currentQuestionIndex]['question'] as String,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Answer Options
            ...(_quizData[_currentQuestionIndex]['options'] as List<String>)
                .map((option) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(option),
                        child: Text(option),
                      ),
                    ))
                .toList(),

            // Show Check or Close Icon after answering
            SizedBox(height: 90),
            if (_showCheckIcon)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
            if (_showCloseIcon)
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 50,
              ),
          ],
        ),
      ),
    );
  }
}
