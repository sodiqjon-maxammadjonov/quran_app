import 'dart:collection';

import 'package:flutter/material.dart';

enum MessageType { info, warning, success, error }

class CustomScaffoldMessenger {
  static final Queue<_MessageInfo> _messageQueue = Queue<_MessageInfo>();
  static bool _isShowingMessage = false;
  static OverlayEntry? _currentMessenger;

  static void show({
    required BuildContext context,
    required String message,
    MessageType type = MessageType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Agar bir xil turdagi xabar allaqachon ko'rsatilayotgan bo'lsa yoki navbatda bo'lsa, yangi qo'shmaymiz
    if (_isShowingMessage && _currentMessenger != null) {
      return;
    }

    // Navbatda oldin bor-yo‘qligini tekshiramiz
    if (_messageQueue.any((msg) => msg.type == type)) {
      return;
    }

    _messageQueue.add(_MessageInfo(
      context: context,
      message: message,
      type: type,
      duration: duration,
    ));

    if (!_isShowingMessage) {
      _showNextMessage();
    }
  }


  static void _showNextMessage() {
    if (_messageQueue.isEmpty) {
      _isShowingMessage = false;
      return;
    }

    _isShowingMessage = true;
    final messageInfo = _messageQueue.removeFirst();
    final overlay = Overlay.of(messageInfo.context);
    final appBarHeight = AppBar().preferredSize.height;

    _hideCurrentMessenger();

    OverlayEntry entry = OverlayEntry(
      builder: (context) => _CustomMessengerWidget(
        message: messageInfo.message,
        type: messageInfo.type,
        duration: messageInfo.duration,
        onDismiss: () {
          _hideCurrentMessenger();
          _showNextMessage();
        },
        appBarHeight: appBarHeight,
      ),
    );

    _currentMessenger = entry;

    overlay.insert(entry);

    Future.delayed(messageInfo.duration, () {
      if (_currentMessenger == entry) {
        _hideCurrentMessenger();
        _showNextMessage();
      }
    });
  }

  static void _hideCurrentMessenger() {
    _currentMessenger?.remove();
    _currentMessenger = null;
  }
}

class _MessageInfo {
  final BuildContext context;
  final String message;
  final MessageType type;
  final Duration duration;

  _MessageInfo({
    required this.context,
    required this.message,
    required this.type,
    required this.duration,
  });
}

class _CustomMessengerWidget extends StatefulWidget {
  final String message;
  final MessageType type;
  final Duration duration;
  final VoidCallback onDismiss;
  final double appBarHeight;

  const _CustomMessengerWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
    required this.appBarHeight,
  });

  @override
  _CustomMessengerWidgetState createState() => _CustomMessengerWidgetState();
}

class _CustomMessengerWidgetState extends State<_CustomMessengerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from right
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case MessageType.info:
        return Icons.info_outline;
      case MessageType.warning:
        return Icons.warning_amber_outlined;
      case MessageType.success:
        return Icons.check_circle_outline;
      case MessageType.error:
        return Icons.error_outline;
    }
  }

  Color _getColor() {
    switch (widget.type) {
      case MessageType.info:
        return Colors.blue;
      case MessageType.warning:
        return Colors.orange;
      case MessageType.success:
        return Colors.green;
      case MessageType.error:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    // Maksimal o'lchamlar
    double maxWidth = screenWidth < 600 ? 400 : 500;
    double maxHeight = screenHeight * 0.15; // 15% dan oshmasin

    return Positioned(
      top: widget.appBarHeight + MediaQuery
          .of(context)
          .padding
          .top,
      left: (screenWidth - maxWidth) / 2, // Markazga joylashtiramiz
      width: maxWidth,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! < -300) {
              _dismiss();
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: _getColor().withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getIcon(), color: Colors.white, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: _dismiss,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}