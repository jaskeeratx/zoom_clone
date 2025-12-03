import 'package:flutter/foundation.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';


import 'auth_methods.dart';
import 'generate_gwt.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();

  void createNewMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
  }) async {
    try {
      final user = _authMethods.user;

      // Generate JWT
      final token = JitsiJwtService.generateToken(
        roomName: roomName,
        userName: _authMethods.user.displayName ?? "Guest",
        userEmail: _authMethods.user.email ?? "",
        avatarUrl: _authMethods.user.photoURL,
      );

      var options = JitsiMeetConferenceOptions(
        serverURL: "https://8x8.vc/vpaas-magic-cookie-7554441ffe0f40baacc0ceef248bf466",
        room: "${JitsiJwtService.appId}/$roomName",
        token: token, // 🔥 IMPORTANT!
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "disableLobby": true,
        },
        featureFlags: {
          FeatureFlags.lobbyModeEnabled: false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: _authMethods.user.displayName,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
      await JitsiMeet().join(options);


    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
