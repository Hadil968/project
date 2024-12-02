import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultPage({
    super.key,
    required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    double score = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//
          children: [
           const Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 20),
            Text(
              'Total Questions: $totalQuestions',
              style:const TextStyle(fontSize: 20),
            ),
            Text(
              'Correct Answers: $correctAnswers',
              style:const TextStyle(fontSize: 20),
            ),
           const SizedBox(height: 20),
            Text(
              'Your Score: ${score.toStringAsFixed(2)}%',
              style:const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),


           const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Exit to Home or another page
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child:const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
