import 'package:flutter/material.dart';
import 'math_engine.dart';

enum GamePhase { home, assessment, game, result }

class GameState extends ChangeNotifier {
  int _currentLevel = 1;
  int _score = 0;
  int _consecutiveCorrect = 0;
  int _questionsCount = 0;
  bool _isAssessment = false;
  GamePhase _phase = GamePhase.home;

  MathProblem? _currentProblem;
  final MathEngine _engine = MathEngine();

  int get currentLevel => _currentLevel;
  int get score => _score;
  GamePhase get phase => _phase;
  MathProblem? get currentProblem => _currentProblem;
  bool get isAssessment => _isAssessment;
  int get questionsCount => _questionsCount;

  void startAssessment() {
    _isAssessment = true;
    _currentLevel = 1;
    _score = 0;
    _questionsCount = 0;
    _phase = GamePhase.assessment;
    nextProblem();
  }

  void startGame([int? level]) {
    _isAssessment = false;
    if (level != null) {
      _currentLevel = level;
    }
    _score = 0;
    _consecutiveCorrect = 0;
    _questionsCount = 0;
    _phase = GamePhase.game;
    nextProblem();
  }

  void nextProblem() {
    _currentProblem = _engine.generateProblem(_currentLevel);
    notifyListeners();
  }

  bool checkAnswer(int answer) {
    bool isCorrect = _currentProblem?.answer == answer;
    _questionsCount++;

    if (isCorrect) {
      _score++;
      _consecutiveCorrect++;

      if (!_isAssessment) {
        // In game mode, level up every 5 correct answers
        if (_consecutiveCorrect >= 5) {
          _currentLevel++;
          _consecutiveCorrect = 0;
        }
      }
    } else {
      _consecutiveCorrect = 0;
    }

    if (_isAssessment && _questionsCount >= 10) {
      // End assessment after 10 questions
      _currentLevel = (_score * 2).clamp(1, 100); // Simple level mapping
      _phase = GamePhase.result;
    } else if (!_isAssessment && _questionsCount >= 20) {
      // Simple session end for game
      _phase = GamePhase.result;
    } else {
      nextProblem();
    }

    notifyListeners();
    return isCorrect;
  }

  void goToHome() {
    _phase = GamePhase.home;
    notifyListeners();
  }
}
