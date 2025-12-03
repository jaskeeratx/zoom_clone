import 'package:flutter/material.dart';
import 'package:untitled/utils/colours.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Join a meeting', style: TextStyle(fontSize: 18)),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Room-ID',
            ),
          ),
        ],
      ),
    );
  }
}
