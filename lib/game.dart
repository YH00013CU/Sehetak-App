import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GameScreen(),
  ));
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid Quiz'),
      ),
      body: QuestionList(),
    );
  }
}

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  int _questionIndex = 0;
  int _correctAnswers = 0;
  List<Question> questions = [
    Question(
      question: 'What is the first step in providing first aid?',
      options: [
        Option(answer: 'Assess the situation', icon: Icons.warning, color: Colors.blue),
        Option(answer: 'Apply pressure to the wound', icon: Icons.local_hospital, color: Colors.orange),
        Option(answer: 'Give CPR', icon: Icons.favorite, color: Colors.red),
        Option(answer: 'Elevate the injured area', icon: Icons.accessibility_new, color: Colors.green),
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'How should you treat a minor burn?',
      options: [
        Option(answer: 'Apply ice directly to the burn', icon: Icons.ac_unit, color: Colors.blue),
        Option(answer: 'Run cool water over the burn', icon: Icons.water_damage, color: Colors.pink),
        Option(answer: 'Apply a warm compress', icon: Icons.thermostat, color: Colors.orange),
        Option(answer: 'Remove clothing from burn area', icon: Icons.wash_rounded, color: Colors.green),
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'What should you do if someone is choking?',
      options: [
        Option(answer: 'Offer them a glass of water', icon: Icons.local_drink, color: Colors.blue),
        Option(answer: 'Perform abdominal thrusts ', icon: Icons.directions_run, color: Colors.red),
        Option(answer: 'Give them a back massage', icon: Icons.backspace, color: Colors.green),
        Option(answer: 'Pat their back firmly', icon: Icons.format_bold, color: Colors.pink),
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'How should you stop bleeding from a wound?',
      options: [
        Option(answer: 'Apply pressure with clean bandage', icon: Icons.cleaning_services, color: Colors.green),
        Option(answer: 'Apply ice directly to the wound', icon: Icons.ac_unit, color: Colors.blue),
        Option(answer: 'Pour alcohol over the wound', icon: Icons.wine_bar, color: Colors.red),
        Option(answer: 'Use a tourniquet to stop blood flow', icon: Icons.blur_circular, color: Colors.orange),
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'What is the universal sign for choking?',
      options: [
        Option(answer: 'Hands covering ears', icon: Icons.hearing, color: Colors.blue),
        Option(answer: 'Hands over eyes', icon: Icons.remove_red_eye, color: Colors.red),
        Option(answer: 'Hands clutching the throat', icon: Icons.fiber_manual_record, color: Colors.green),
        Option(answer: 'Hands waving in the air', icon: Icons.airline_seat_flat, color: Colors.pink),
      ],
      correctAnswerIndex: 2,
    ),
  ];

  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correct!' : 'Incorrect!'),
          content: Text(
            isCorrect
                ? 'Well done!'
                : 'The correct answer is: ${questions[_questionIndex].options[questions[_questionIndex].correctAnswerIndex].answer}',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isCorrect) {
                  _correctAnswers++;
                }
                if (_questionIndex < questions.length - 1) {
                  setState(() {
                    _questionIndex++;
                  });
                } else {
                  _showScoreDialog(context); // Pass context to show score dialog
                }
              },
              child: Text('Next Question'),
            ),
          ],
        );
      },
    );
  }

  void _showScoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Text('You scored $_correctAnswers out of ${questions.length}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Pop the dialog's route
                Navigator.of(context).pop();
                // Pop remaining routes until reaching the home page
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _questionIndex < questions.length
        ? QuestionTile(
            question: questions[_questionIndex],
            onAnswerSelected: (selectedOptionIndex) {
              bool isCorrect = selectedOptionIndex == questions[_questionIndex].correctAnswerIndex;
              _showResultDialog(isCorrect);
            },
          )
        : SizedBox(); // Return an empty SizedBox instead of the Show Score button
  }
}

class Question {
  final String question;
  final List<Option> options;
  final int correctAnswerIndex;

  Question({required this.question, required this.options, required this.correctAnswerIndex});
}

class Option {
  final String answer;
  final IconData icon;
  final Color color;

  Option({required this.answer, required this.icon, required this.color});
}

class QuestionTile extends StatelessWidget {
  final Question question;
  final Function(int) onAnswerSelected;

  QuestionTile({
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: question.options.map((option) {
                return InkWell(
                  onTap: () {
                    final selectedOptionIndex = question.options.indexOf(option);
                    onAnswerSelected(selectedOptionIndex);
                  },
                  child: Container(
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: option.color.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          option.icon,
                          color: Colors.white,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            option.answer,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
