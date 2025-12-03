import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:untitled/components/home_screen_action_buttons.dart';
import 'package:untitled/services/jitsi_meet_methods.dart';

class MeetingScreen extends StatelessWidget {
   MeetingScreen({
    super.key,
  });
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();


   Future<void> createNewMeeting() async{
    var random = Random();
    String roomName = (random.nextInt(100000000)+ 1000000).toString();
    _jitsiMeetMethods.createNewMeeting(roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

   void joinMeeting(BuildContext context){
    Navigator.pushNamed(context, '/video-call');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeScreenActionButtons(
              onPressed: createNewMeeting,
              icon: Icons.video_call,
              text: 'New Meeting',
            ),
            HomeScreenActionButtons(
              onPressed: ()=>joinMeeting(context),
              icon: Icons.add_box_rounded,
              text: 'Join Meeting',
            ),
            HomeScreenActionButtons(
              onPressed: () {},
              icon: Icons.calendar_month,
              text: 'Schedule Meet',
            ),
            HomeScreenActionButtons(
              onPressed: () {},
              icon: Icons.arrow_upward,
              text: 'Share Screen  ',
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join a meet with just one click',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
