import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'features/chat/presentation/screens/chat_screen.dart';

class VoiceChatApp extends StatelessWidget {
  const VoiceChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Voice Chat',
      theme: AppTheme.lightTheme,
      home: const ChatScreen(), // will later connect to route management
    );
  }
}
