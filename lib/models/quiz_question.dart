/// A single multiple-choice quiz question generated from the study material.
class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
 
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
  /// Builds a [QuizQuestion] from a decoded JSON map, validating that
  /// every required field is present and internally consistent.
  ///
  /// Throws a [FormatException] with a human-readable message if the
  /// data is missing, has the wrong type, or is inconsistent (e.g. the
  /// correct answer doesn't match any of the options).
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final question = json['question'];
    if (question is! String || question.trim().isEmpty) {
      throw const FormatException('a quiz question is missing its text');
    }

    final rawOptions = json['options'];
    if (rawOptions is! List || rawOptions.length < 2) {
      throw const FormatException('a quiz question is missing answer options');
    }
    final options = rawOptions.map((option) => option.toString()).toList();

    final correctAnswer = json['correctAnswer'];
    if (correctAnswer is! String || correctAnswer.trim().isEmpty) {
      throw const FormatException('a quiz question is missing a correct answer');
    }
    if (!options.contains(correctAnswer)) {
      throw const FormatException(
        "a quiz question's correct answer does not match any of its options",
      );
    }

    final explanation = json['explanation'];

    return QuizQuestion(
      question: question,
      options: options,
      correctAnswer: correctAnswer,
      explanation: explanation is String && explanation.trim().isNotEmpty
          ? explanation
          : 'No explanation was provided.',
    );
  }
}
