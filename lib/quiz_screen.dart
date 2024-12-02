import 'package:flutter/material.dart';
import 'package:mobil_app/result_screen.dart';

class QuizPage extends StatefulWidget {
  final String difficulty;
  final String operation;

  const QuizPage({
    super.key,
    required this.difficulty,
    required this.operation,
  });

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int remainingTime = 30; // Timer for each question (30 seconds)
  bool isAnswered = false;
  bool questionsLoaded = false;
  String userAnswer = '';
  int correctAnswers=0;
  List<String>userAnswers=[];

  // To decrement the timer
  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (remainingTime > 0 && !isAnswered) {
        setState(() {
          remainingTime--;
        });
        startTimer(); // Continue the timer
      } else if (remainingTime == 0) {
        // Move to the next question when time runs out
        setState(() {
          isAnswered = true;// Mark as answered to avoid duplicate triggers
          userAnswers.add('0');
        });
        nextQuestion();
      }
    });
  }


  // Load questions based on difficulty and operation
  void loadQuestions() {
    if (widget.difficulty == 'Easy') {
      if (widget.operation == 'Addition') {
        questions = [
          {'question': '2 + 2 =  ', 'options': ['2', '3', '4', '5'], 'answer': '4'},
          {'question': '3 + 1 =  ', 'options': ['2', '4', '6', '8'], 'answer': '4'},
          {'question': '5 + 3 =  ', 'options': ['7', '8', '9', '10'], 'answer': '8'},
        ];
      } else if (widget.operation == 'Subtraction') {
        questions = [
          {'question': '5 - 3 =   ', 'options': ['2', '3', '4', '5'], 'answer': '2'},
          {'question': '7 - 2 =   ', 'options': ['5', '4', '3', '2'], 'answer': '5'},
          {'question': '9 - 4 =   ', 'options': ['6', '5', '7', '8'], 'answer': '5'},
        ];
      } else if (widget.operation == 'Multiplication') {
        questions = [
          {'question': '2 x 3 =  ', 'options': ['6', '7', '8', '5'], 'answer': '6'},
          {'question': '4 x 2 =  ', 'options': ['8', '6', '7', '5'], 'answer': '8'},
          {'question': '3 x 3 =  ', 'options': ['6', '7', '9', '10'], 'answer': '9'},
        ];
      }
    } else if (widget.difficulty == 'Medium') {
      if (widget.operation == 'Addition') {
        questions = [
          {'question': '12 + 8 =   ', 'options': ['18', '20', '22', '14'], 'answer': '20'},
          {'question': '17 + 9 =   ', 'options': ['24', '26', '28', '30'], 'answer': '26'},
          {'question': '23 + 11 =   ', 'options': ['32', '34', '36', '28'], 'answer': '34'},
        ];
      } else if (widget.operation == 'Subtraction') {
        questions = [
          {'question': '22 - 8 =    ', 'options': ['12', '14', '16', '18'], 'answer': '14'},
          {'question': '35 - 12 =   ', 'options': ['21', '23', '25', '27'], 'answer': '23'},
          {'question': '47 - 21 =   ', 'options': ['23', '25', '27', '28'], 'answer': '26'},
        ];
      } else if (widget.operation == 'Multiplication') {
        questions = [
          {'question': '12 x 4 =  ', 'options': ['42', '48', '50', '56'], 'answer': '48'},
          {'question': '15 x 3 =  ', 'options': ['40', '45', '50', '55'], 'answer': '45'},
          {'question': '8 x 7 =  ', 'options': ['56', '60', '63', '65'], 'answer': '56'},
        ];
      }
    } else if (widget.difficulty == 'Hard') {
      if (widget.operation == 'Addition') {
        questions = [
          {'question': '123 + 456 =  ', 'options': ['550', '580', '590', '579'], 'answer': '579'},
          {'question': '789 + 234 =  ', 'options': ['999', '1023', '1000', '1050'], 'answer': '1023'},
          {'question': '567 + 999 =  ', 'options': ['1576', '1566', '1556', '1599'], 'answer': '1566'},
        ];
      } else if (widget.operation == 'Subtraction') {
        questions = [
          {'question': '1000 - 789 =  ', 'options': ['211', '220', '222', '230'], 'answer': '211'},
          {'question': '1000 - 345 =  ', 'options': ['655', '667', '654', '630'], 'answer': '655'},
          {'question': '756 - 300 =  ', 'options': ['445', '440', '450', '460'], 'answer': '456'},
        ];
      } else if (widget.operation == 'Multiplication') {
        questions = [
          {'question': '25 x 18 =  ', 'options': ['440', '450', '455', '460'], 'answer': '450'},
          {'question': '50 x 16 =  ', 'options': ['800', '750', '820', '900'], 'answer': '800'},
          {'question': '14 x 35 =  ', 'options': ['490', '500', '550', '480'], 'answer': '490'},
        ];
      }
    }

    setState(() {
      questionsLoaded = true;
    });

    startTimer(); // Start the timer once questions are loaded
  }

  // Navigate to the next question
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        remainingTime = 30; // Reset timer for the next question
        isAnswered = false;
        userAnswer = ''; // Reset user answer
      });
      startTimer(); // Restart the timer for the next question
    } else {
      showResult(); // If it's the last question, show the result
    }
  }


  // Display the result at the end of the quiz
  void showResult() {
    //showDialog(
      //context: context,
      //builder: (context) => AlertDialog(
       // title: const Text('Quiz Completed!'),
       // content: const Text('You have completed the quiz.'),
      //  actions: [
      //    TextButton(
      //      onPressed: () => Navigator.pop(context),
       //     child: const Text('OK'),
         // ),
     //   ],
    //  ),
   // );
    int correctAnswers=0;
    for (int i=0;i<questions.length;i++){
      if(userAnswers[i] == questions[i]['answer']){
        correctAnswers++;
      }
    }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>
              ResultPage(correctAnswers: correctAnswers, totalQuestions: questions.length),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    if (!questionsLoaded) {
      loadQuestions();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.operation} Quiz - ${widget.difficulty} Level'),
        centerTitle: true,
      ),
      body: questionsLoaded
          ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                questions[currentQuestionIndex]['options'].length,
                    (index) {
                  String option = questions[currentQuestionIndex]['options'][index];
                  return ElevatedButton(
                    onPressed: isAnswered
                        ? null
                        : () {
                      setState(() {
                        userAnswer = option;
                        userAnswers.add(userAnswer);
                        isAnswered = true; // Mark the question as answered
                        if (userAnswer == questions[currentQuestionIndex]['answer']){
                          correctAnswers++;
                        }
                      });
                    },
                    child: Text(option),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Time remaining: $remainingTime sec'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isAnswered ? nextQuestion : null,
              child: const Text('Next Question'),
            ),
          ],
        ),
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
