import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AichatScreen extends StatefulWidget {
  const AichatScreen({super.key});

  @override
  State<AichatScreen> createState() => _AichatScreenState();
}

class _AichatScreenState extends State<AichatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [];


  // ⭐ PUT GEMINI KEY HERE
  final String apiKey = "AIzaSyBpeAOfQ7MQ3IJaUyq2xSgsHcBXp2T7wkY";

  String userContext = "";

  @override
  void initState() {
    super.initState();

    _loadUserContext();

    // ⭐ add first AI message with current time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add({
          "text":
          "Hello! I'm your AI assistant. How can I help you with your career today?",
          "isMe": false,
          "time": TimeOfDay.now().format(context),
        });
      });
    });
  }


  // ================= LOAD USER PROFILE =================
  Future<void> _loadUserContext() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final data = doc.data() ?? {};

    userContext = """
Student Profile:
Education: ${data["education"]}
Stream: ${data["stream"]}
Interests: ${data["interests"]}
Recommended Careers: ${data["recommendedCareers"]}
""";
  }

  // ================= ONLY LOGIC CHANGED HERE =================
  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final text = _messageController.text;

    setState(() {
      _messages.add({
        "text": text,
        "isMe": true,
        "time": TimeOfDay.now().format(context),
      });
      _messageController.clear();
    });

    // typing bubble
    setState(() {
      _messages.add({
        "text": "Typing...",
        "isMe": false,
        "time": TimeOfDay.now().format(context),
      });
    });

    final reply = await _askGemini(text);

    setState(() {
      _messages.removeLast(); // remove typing
      _messages.add({
        "text": reply,
        "isMe": false,
        "time": TimeOfDay.now().format(context),
      });
    });
  }

  // ================= GEMINI API =================
  Future<String> _askGemini(String message) async {
    try {
      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
        ),



        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                  "You are Guidance-Mate AI, a friendly career counselor.\n$userContext\nUser question: $message"
                }
              ]
            }
          ]
        }),
      );

      final data = jsonDecode(response.body);

      print(data); // debug

      // ⭐ SAFE CHECK
      if (data["candidates"] == null) {
        return data["error"]?["message"] ?? "API error occurred";
      }

      return data["candidates"][0]["content"]["parts"][0]["text"];
    } catch (e) {
      print("Gemini error: $e");
      return "Connection failed. Check internet or API key.";
    }
  }

  // ================= YOUR ORIGINAL UI BELOW (UNCHANGED) =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent.shade100,
              child: const Icon(Icons.smart_toy_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Guidance-Mate AI",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.green.shade600, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(
                  message["text"],
                  message["isMe"],
                  message["time"],
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // ===== EXACT SAME BUBBLE =====
  Widget _buildMessageBubble(String text, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== EXACT SAME INPUT =====
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
