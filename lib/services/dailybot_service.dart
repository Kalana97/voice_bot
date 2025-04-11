import 'dart:convert';
import 'package:http/http.dart' as http;

class DailyBotService {
  static const String _apiUrl = 'https://api.dailybot.com/v1/chat';  //endpoint of the bot
  static const String _apiKey = 'YOUR_API_KEY_HERE'; // Replace this with your token
  static const String _conversationId = 'kalana-demo-chat'; // You can make this dynamic if needed

  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'input': message,
        'conversation_id': _conversationId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['output'] ?? "No response from DailyBot.";
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return "Failed to get response.";
    }
  }
}
