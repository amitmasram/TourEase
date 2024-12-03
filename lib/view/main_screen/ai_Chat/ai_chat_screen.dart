import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/colors.dart';
import '../../../core/helpers/helper.dart';
import 'ai_textfield.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(dark),
            Expanded(child: _buildChatArea(dark)),
            _buildInputArea(controller, dark),
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
            'AI Assistant',
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
      child: ListView(
        children: [
          _buildChatBubble("How can I assist you today?", isUser: false, isDarkMode: isDarkMode),
          _buildChatBubble("I need help with a theme-aware UI design.", isUser: true, isDarkMode: isDarkMode),
          _buildChatBubble("Certainly! I'd be happy to help. What specific elements are you looking to incorporate in your theme-aware UI?", isUser: false, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, {required bool isUser, required bool isDarkMode}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          // Apply low-contrast gradient color for the user's message
          gradient: isUser
              ? LinearGradient(
                  colors: [
                    Color(0xffd1e7f5),  // Light sky blue
                    Color(0xffe2c8f7),  // Light lavender
                    Color(0xffcbb3f8),  // Light periwinkle
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
            color: isUser ? Colors.black87 : (isDarkMode ? Colors.white : Colors.black87),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(TextEditingController controller, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: AiTextField(
              controller: controller,
              obscureText: false,
              hintText: 'Type your message...',
              isDarkMode: isDarkMode,
            ),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.paperPlane,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Add your send functionality here
            },
          ),
        ],
      ),
    );
  }
}
