// define QuestionData constructor
class QuestionData {
  String question;
  int attempts;
  double score;
  int id;

  QuestionData({
    required this.question,
    required this.attempts,
    required this.score,
    required this.id,
  });

  double calculatePlaybackSpeed() {
    return 1 - (0.25 * attempts * (1 - score));
  }

}