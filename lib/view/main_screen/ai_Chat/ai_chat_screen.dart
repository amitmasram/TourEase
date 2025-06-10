import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ai_textfield.dart';

class Message {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final String? imageUrl;

  Message({
    required this.content,
    required this.isUser,
    this.imageUrl,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = false;
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final String _pixabayApiKey =
      'YOUR_PIXABAY_API_KEY'; // Replace with your Pixabay API key

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    const apiKey = 'AIzaSyCDv8WgaWR5IL99I6T-O7n3JXmFNg6GeEY';
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
    );

    _chat = _model.startChat(history: [
      Content.text(
          'You are a knowledgeable travel assistant. Help users discover places and provide detailed information. '
          'When users ask about specific places or want to see images, provide descriptions and also mention '
          '[I can show you images of this place]. Keep responses informative but concise.'),
    ]);
  }

  Future<String?> _fetchImageUrl(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://pixabay.com/api/?key=$_pixabayApiKey&q=${Uri.encodeComponent(query)}&image_type=photo&per_page=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hits'] != null && data['hits'].isNotEmpty) {
          return data['hits'][0]['webformatURL'];
        }
      }
    } catch (e) {
      debugPrint('Error fetching image: $e');
    }
    return null;
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(content: message, isUser: true));
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await _chat.sendMessage(Content.text(message));
      final responseText =
          response.text ?? 'I apologize, but I couldn\'t generate a response.';

      String? imageUrl;
      if (message.toLowerCase().contains('show') &&
              message.toLowerCase().contains('image') ||
          responseText.contains('[I can show you images of this place]')) {
        // Extract place name from the message or response
        String searchQuery = message
            .toLowerCase()
            .replaceAll('show', '')
            .replaceAll('image', '')
            .replaceAll('of', '')
            .trim();
        imageUrl = await _fetchImageUrl(searchQuery);
      }

      setState(() {
        _messages.add(Message(
          content: responseText.replaceAll(
              '[I can show you images of this place]', ''),
          isUser: false,
          imageUrl: imageUrl,
        ));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(Message(
          content: 'I apologize, but I encountered an error. Please try again.',
          isUser: false,
        ));
        _isLoading = false;
      });
      debugPrint('Error in chat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(dark),
            Expanded(child: _buildChatArea(dark)),
            if (_isLoading) const LinearProgressIndicator(),
            _buildInputArea(dark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.robot,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 12),
          Text(
            'Travel Assistant',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[_messages.length - 1 - index];
          return _buildMessageItem(message, isDarkMode);
        },
      ),
    );
  }

  Widget _buildMessageItem(Message message, bool isDarkMode) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: message.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            _buildChatBubble(message.content,
                isUser: message.isUser, isDarkMode: isDarkMode),
            if (message.imageUrl != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  message.imageUrl!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 200,
                      height: 150,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 150,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.error_outline),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message,
      {required bool isUser, required bool isDarkMode}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: isUser
            ? const LinearGradient(
                colors: [
                  Color(0xffd1e7f5),
                  Color(0xffe2c8f7),
                  Color(0xffcbb3f8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: !isUser
            ? (isDarkMode ? Colors.grey[800] : Colors.white.withOpacity(0.8))
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isUser
              ? Colors.black87
              : (isDarkMode ? Colors.white : Colors.black87),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInputArea(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AiTextField(
              controller: _controller,
              obscureText: false,
              hintText: 'Ask about any destination...',
              isDarkMode: isDarkMode,
            ),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.paperPlane,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 20,
            ),
            onPressed: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
