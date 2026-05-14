import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game_state.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final isAssessment = gameState.isAssessment;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAssessment ? Icons.assignment_turned_in : Icons.emoji_events,
              size: 100,
              color: Colors.amber,
            ),
            const SizedBox(height: 24),
            Text(
              isAssessment ? 'Assessment Complete' : 'Session Finished',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Your Score: ${gameState.score} / ${isAssessment ? 10 : 20}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              'Current Level: ${gameState.currentLevel}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => gameState.startGame(gameState.currentLevel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('CONTINUE TRAINING', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => gameState.goToHome(),
              child: const Text('BACK TO MENU', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
