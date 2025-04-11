import 'package:flutter/material.dart';
import 'package:voice_bot_app/features/history/presentation/screens/history_screen.dart';
import 'package:voice_bot_app/widgets/app_bottom_nav.dart';
// import 'package:voice_chat/widgets/app_bottom_nav.dart';
import '../widgets/voice_input_area.dart';
// import 'history_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const VoiceInputArea(),
    const HistoryScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: AppBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
