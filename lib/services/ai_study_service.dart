import 'package:studylens_ai/models/sudy_result.dart';

/// Abstraction over "something that turns raw study text into a
/// [StudyResult]". Today this is implemented by [MockAiStudyService].
/// Later, a real implementation (e.g. one that calls an AI API) can
/// be swapped in without changing any screen code.
abstract class AiStudyService {
  Future<StudyResult> generateStudyMaterial(String inputText);
}
 