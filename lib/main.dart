import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_bot_app/app.dart';
import 'features/chat/logic/message_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: const VoiceChatApp(),
    ),
  );
}
