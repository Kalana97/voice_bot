import 'package:flutter/material.dart';
import '../data/message_model.dart';

class MessageProvider with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => List.unmodifiable(_messages);

  void addMessage(String text, {required bool isBot}) {
    _messages.insert(
      0,
      Message(
        text: text,
        timestamp: DateTime.now(),
        isBot: isBot, 
      ),
    );
    notifyListeners();
  }

  // Optionally, you can add methods for adding user or bot-specific messages
  void addUserMessage(String text) {
    addMessage(text, isBot: false);
  }

  void addBotMessage(String text) {
    addMessage(text, isBot: true);
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
