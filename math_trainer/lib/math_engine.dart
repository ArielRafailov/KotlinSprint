import 'dart:math';

enum Operation { addition, subtraction, multiplication, division }

class MathProblem {
  final String expression;
  final int answer;

  MathProblem({required this.expression, required this.answer});
}

class MathEngine {
  final Random _random = Random();

  MathProblem generateProblem(int level) {
    // Determine which operations are available at this level
    List<Operation> availableOperations = [Operation.addition];
    if (level >= 3) availableOperations.add(Operation.subtraction);
    if (level >= 7) availableOperations.add(Operation.multiplication);
    if (level >= 12) availableOperations.add(Operation.division);

    Operation op = availableOperations[_random.nextInt(availableOperations.length)];

    switch (op) {
      case Operation.addition:
        return _generateAddition(level);
      case Operation.subtraction:
        return _generateSubtraction(level);
      case Operation.multiplication:
        return _generateMultiplication(level);
      case Operation.division:
        return _generateDivision(level);
    }
  }

  MathProblem _generateAddition(int level) {
    int maxRange = 5 + (level * 5);
    int a = _random.nextInt(maxRange) + 1;
    int b = _random.nextInt(maxRange) + 1;
    return MathProblem(expression: '$a + $b', answer: a + b);
  }

  MathProblem _generateSubtraction(int level) {
    int maxRange = 5 + (level * 5);
    int a = _random.nextInt(maxRange) + 2;
    int b = _random.nextInt(a - 1) + 1; // Ensure positive result
    return MathProblem(expression: '$a - $b', answer: a - b);
  }

  MathProblem _generateMultiplication(int level) {
    int maxRange = 2 + (level ~/ 2);
    int a = _random.nextInt(maxRange) + 1;
    int b = _random.nextInt(maxRange) + 1;
    return MathProblem(expression: '$a * $b', answer: a * b);
  }

  MathProblem _generateDivision(int level) {
    int maxRange = 2 + (level ~/ 3);
    int b = _random.nextInt(maxRange) + 1;
    int answer = _random.nextInt(maxRange) + 1;
    int a = b * answer; // Ensure integer result
    return MathProblem(expression: '$a / $b', answer: answer);
  }
}
