import 'package:flutter_test/flutter_test.dart';
import 'package:math_trainer/math_engine.dart';

void main() {
  group('MathEngine Tests', () {
    final engine = MathEngine();

    test('generateProblem returns a problem with addition for level 1', () {
      final problem = engine.generateProblem(1);
      expect(problem.expression, contains('+'));
      expect(problem.answer, isA<int>());
    });

    test('generateProblem can return subtraction for level 5', () {
      bool sawSubtraction = false;
      for (int i = 0; i < 50; i++) {
        final problem = engine.generateProblem(5);
        if (problem.expression.contains('-')) {
          sawSubtraction = true;
          break;
        }
      }
      expect(sawSubtraction, isTrue);
    });

    test('generateProblem can return multiplication for level 10', () {
      bool sawMultiplication = false;
      for (int i = 0; i < 50; i++) {
        final problem = engine.generateProblem(10);
        if (problem.expression.contains('*')) {
          sawMultiplication = true;
          break;
        }
      }
      expect(sawMultiplication, isTrue);
    });

    test('generateProblem can return division for level 15', () {
      bool sawDivision = false;
      for (int i = 0; i < 100; i++) {
        final problem = engine.generateProblem(15);
        if (problem.expression.contains('/')) {
          sawDivision = true;
          break;
        }
      }
      expect(sawDivision, isTrue);
    });
  });
}
