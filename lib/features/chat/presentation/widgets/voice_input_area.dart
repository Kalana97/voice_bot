import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:voice_bot_app/features/chat/logic/message_provider.dart';
import 'package:voice_bot_app/features/chat/logic/voice_transcriber.dart';

class VoiceInputArea extends StatefulWidget {
  const VoiceInputArea({super.key});

  @override
  State<VoiceInputArea> createState() => _VoiceInputAreaState();
}

class _VoiceInputAreaState extends State<VoiceInputArea> {
  final VoiceTranscriber _transcriber = VoiceTranscriber();
  final FlutterTts _flutterTts = FlutterTts();

  String _transcribedText = "";
  bool _isListening = false;

  final List<_ConversationMessage> _conversation = [];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _initializeTTS();
  }

  Future<void> _initializeSpeech() async {
    final available = await _transcriber.initSpeech();
    if (!available) {
      setState(() {
        _transcribedText =
            "Speech recognition unavailable. Please check permissions.";
      });
    }
  }

  Future<void> _initializeTTS() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.45);
  }

  void _toggleListening() async {
    if (_isListening) {
      _transcriber.stopListening();
      setState(() => _isListening = false);

      final userText = _transcribedText.trim();
      if (userText.isNotEmpty) {
        setState(() {
          _conversation.add(_ConversationMessage(text: userText, isUser: true));
          _conversation.add(_ConversationMessage(
              text: "🤖 Bot is thinking...", isUser: false));
        });

        await Future.delayed(const Duration(milliseconds: 800));

        final String botReply = "Here’s a smart bot reply to: \"$userText\"";

        setState(() {
          _conversation.removeLast(); // remove "thinking..."
          _conversation.add(
            _ConversationMessage(text: botReply, isUser: false),
          );
          context.read<MessageProvider>().addUserMessage(userText);
          context.read<MessageProvider>().addBotMessage(botReply);
          _transcribedText = "";
        });

        // 🔊 Speak the bot reply
        await _flutterTts.speak(botReply);

         // ✅ Process the transcribed text after stopping
        //     // final userText = _transcribedText.trim();
        //     // if (userText.isEmpty) return;

        //     // context.read<MessageProvider>().addUserMessage(userText);

        //     // try {
        //     //   final botReply = await DailyBotService.sendMessage(userText);
        //     //   context.read<MessageProvider>().addBotMessage(botReply);
        //     // } catch (e) {
        //     //   context.read<MessageProvider>().addBotMessage("Bot error: ${e.toString()}");
        //     // }
        
      }
    } else {
      setState(() {
        _isListening = true;
        _transcribedText = "";
      });

      _transcriber.startListening((text) {
        setState(() {
          _transcribedText = text;
        });
      });
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _transcriber.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "🎤 Welcome to AI Voice Chat!\nTap the mic and start speaking. Your voice will be transcribed in real-time.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: _conversation.isEmpty
                  ? const Center(
                      child: Text(
                        "🗣️ Start speaking and your messages will show here...",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _conversation.length,
                      itemBuilder: (context, index) {
                        final msg = _conversation[index];
                        return Align(
                          alignment: msg.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: msg.isUser
                                  ? Colors.deepPurple
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: msg.isUser
                                  ? null
                                  : Border.all(color: Colors.deepPurple),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: msg.isUser
                                    ? Colors.white
                                    : Colors.deepPurple,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: _toggleListening,
            label: Text(_isListening ? "Stop Listening" : "Start Talking"),
            icon: Icon(_isListening ? Icons.stop : Icons.mic),
            backgroundColor: _isListening ? Colors.red : Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}

class _ConversationMessage {
  final String text;
  final bool isUser;

  _ConversationMessage({required this.text, required this.isUser});
}
