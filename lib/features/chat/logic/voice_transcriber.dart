import 'package:speech_to_text/speech_to_text.dart';

class VoiceTranscriber {
  final SpeechToText _speech = SpeechToText();

  Future<bool> initSpeech() async {
    return await _speech.initialize(
      onStatus: (status) => print('🟡 Speech status: $status'),
      onError: (error) => print('🔴 Speech error: $error'),
    );
  }

  void startListening(Function(String) onResult) {
    _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      listenMode: ListenMode.dictation,
      partialResults: true,
    );
  }

  void stopListening() {
    _speech.stop();
  }

  bool get isListening => _speech.isListening;
}
