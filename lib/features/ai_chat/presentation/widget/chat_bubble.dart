import 'dart:async';

import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({super.key, required this.isUser, required this.content});

  final bool isUser;
  final String content;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String _visibleText = '';
  int _currentIndex = 0;
  Timer? _timer;

  void _startTypingEffect() {
    const duration = Duration(milliseconds: 40);
    _timer = Timer.periodic(duration, (timer) {
      if (_currentIndex < widget.content.length) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          _visibleText += widget.content[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _visibleText = '';
    _currentIndex = 0;
    if (!widget.isUser) {
      _startTypingEffect();
    } else {
      _visibleText = widget.content;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: widget.isUser ? AppColors.gray200 : AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(widget.isUser ? 0 : 12),
              bottomRight: Radius.circular(widget.isUser ? 12 : 0),
            ),
          ),
          child: Text(
            _visibleText,
            style: TextStyle(
              color: widget.isUser ? Colors.black : Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
