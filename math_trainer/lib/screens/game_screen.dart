import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController _controller = TextEditingController();
  String _feedback = '';
  Color _feedbackColor = Colors.transparent;

  void _submit() {
    if (_controller.text.isEmpty) return;

    final int? userAnswer = int.tryParse(_controller.text);
    if (userAnswer == null) return;

    final gameState = context.read<GameState>();
    final isCorrect = gameState.checkAnswer(userAnswer);

    setState(() {
      if (isCorrect) {
        _feedback = 'Correct!';
        _feedbackColor = Colors.green;
      } else {
        _feedback = 'Wrong! Answer was ${gameState.currentProblem?.answer}';
        _feedbackColor = Colors.red;
      }
      _controller.clear();
    });

    // Clear feedback after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _feedback = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final problem = gameState.currentProblem;

    return Scaffold(
      appBar: AppBar(
        title: Text(gameState.isAssessment ? 'Assessment' : 'Level ${gameState.currentLevel}'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: gameState.questionsCount / (gameState.isAssessment ? 10 : 20),
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
            const SizedBox(height: 40),
            Text(
              'Question ${gameState.questionsCount + 1}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const Spacer(),
            Text(
              problem?.expression ?? '',
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32),
              autofocus: true,
              decoration: const InputDecoration(
                hintText: '?',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 20),
            Text(
              _feedback,
              style: TextStyle(fontSize: 20, color: _feedbackColor, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('SUBMIT', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
