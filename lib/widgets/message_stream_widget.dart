import 'dart:async';
import 'package:flutter/material.dart';

class MessageStreamWidget extends StatefulWidget {
  const MessageStreamWidget({super.key});

  @override
  State<MessageStreamWidget> createState() => _MessageStreamWidgetState();
}

class _MessageStreamWidgetState extends State<MessageStreamWidget> {
  final List<String> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late StreamController<String> _messageController;
  late StreamSubscription<String> _subscription;

  @override
  void initState() {
    super.initState();
    // Create a StreamController for String messages
    _messageController = StreamController<String>();
    
    // Listen to incoming messages
    _subscription = _messageController.stream.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _messageController.close();
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _textController.text.trim();
    if (message.isNotEmpty) {
      // Add message to the stream
      _messageController.add(message);
      _textController.clear();
    }
  }

  void _sendPresetMessage(String message) {
    // Add preset message to the stream
    _messageController.add(message);
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Explanation card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.message,
                    size: 48,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Message Stream',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Send messages through streams\n'
                    '• Messages appear in real-time\n'
                    '• Streams handle data flow\n'
                    '• Perfect for chat apps!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Message input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _sendMessage,
                child: const Icon(Icons.send),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Preset messages
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Hello!',
              'How are you?',
              'Streams are awesome!',
              'Flutter rocks!',
              'Learning is fun!',
            ].map((message) {
              return ElevatedButton(
                onPressed: () => _sendPresetMessage(message),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade100,
                  foregroundColor: Colors.green.shade800,
                ),
                child: Text(message),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          // Messages display
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages yet. Send one!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green.shade100,
                              child: Icon(
                                Icons.person,
                                color: Colors.green.shade800,
                              ),
                            ),
                            title: Text(_messages[index]),
                            subtitle: Text('Message ${index + 1}'),
                            trailing: Text(
                              '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Clear button
          ElevatedButton.icon(
            onPressed: _clearMessages,
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear Messages'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
} 