import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../chat/logic/message_provider.dart';
import '../../../chat/data/message_model.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<MessageProvider>().messages;

    // If no messages exist
    if (messages.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "🕓 No conversation history yet.\nStart talking and come back later!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final Message msg = messages[index];
        
        return Align(
          alignment: msg.isBot ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: msg.isBot ? Colors.green.shade50 : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: msg.isBot ? Colors.green.shade300 : Colors.blue.shade300,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: msg.isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                // Display message text
                Text(
                  msg.text,
                  style: TextStyle(
                    color: msg.isBot ? Colors.green : Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),

                // Display timestamp
                Text(
                  DateFormat.yMd().add_jm().format(msg.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
