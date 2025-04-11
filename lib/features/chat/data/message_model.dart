class Message {
  final String text;
  final DateTime timestamp;
  final bool isBot; // Add this field

  Message({
    required this.text,
    required this.timestamp,
    required this.isBot, // Initialize isBot in the constructor
  });
}
