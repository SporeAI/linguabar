import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/routing/app_router.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.args});

  final ChatRoomArgs args;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;
  final List<_ChatMessage> _messages = [];

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text.trim();
    _controller.clear();

    setState(() {
      _messages.add(_ChatMessage(
        fromMe: true,
        original: text,
        translated: '',
      ));
      _loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/translate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'session_id': 'demo-room',
          'source_lang': widget.args.sourceLang,
          'target_lang': widget.args.targetLang,
          'text': text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          _messages.add(_ChatMessage(
            fromMe: false,
            original: text,
            translated: data['translated_text'] as String,
          ));
        });
      } else {
        setState(() {
          _messages.add(_ChatMessage(
            fromMe: false,
            original: text,
            translated: 'Ошибка перевода: ${response.statusCode}',
          ));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(_ChatMessage(
          fromMe: false,
          original: text,
          translated: 'Сетевая ошибка: $e',
        ));
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.args.roomName),
            const SizedBox(height: 2),
            Text(
              'Собеседник: ${widget.args.peerName}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surfaceVariant,
            child: Text(
              'Языки: ${widget.args.sourceLang} → ${widget.args.targetLang}',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment:
                      message.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Card(
                    color: message.fromMe
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.original),
                          const SizedBox(height: 6),
                          Text(
                            message.translated.isEmpty
                                ? 'Перевод...'
                                : message.translated,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Скажите или напишите...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _loading ? null : _sendMessage,
                    child: const Text('Отправить'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  _ChatMessage({
    required this.fromMe,
    required this.original,
    required this.translated,
  });

  final bool fromMe;
  final String original;
  final String translated;
}
