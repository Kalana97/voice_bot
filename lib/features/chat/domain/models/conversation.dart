class Conversation {
  final String id;
  final String userInput;
  final String aiResponse;
  final DateTime timestamp;

  Conversation({
    required this.id,
    required this.userInput,
    required this.aiResponse,
    required this.timestamp,
  });
}
