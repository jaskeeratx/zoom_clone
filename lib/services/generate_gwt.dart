import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JitsiJwtService {
  // 1. From your JaaS project
  static const String appId =
      "vpaas-magic-cookie-7554441ffe0f40baacc0ceef248bf466"; // your AppID

  static const String kid =
      "vpaas-magic-cookie-7554441ffe0f40baacc0ceef248bf466/7038ba"; // <-- replace

  // 2. Paste your NEW private key here as a raw PEM string
  //    (from the .pk file, INCLUDING the BEGIN/END lines)
  static final String? _privateKeyPem =dotenv.env['JITSI_PRIVATE_KEY']!.replaceAll(r'\n', '\n');
  static String generateToken({
    required String roomName,
    required String userName,
    required String userEmail,
    String? avatarUrl,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = now + 60 * 60 * 12; // 12 hours

    final jwt = JWT({
      "aud": "jitsi",
      "iss": "chat",
      "sub": appId,
      "room": roomName,
      "iat": now,
      "nbf": now - 5,
      "exp": exp,
      "context": {
        "features": {
          "livestreaming": true,
          "recording": true,
          "outbound-call": true,
        },
        "user": {
          "moderator": true,
          "name": userName,
          "email": userEmail,
          "avatar": avatarUrl ?? "",
        }
      }
    },
        header: {
          "alg": "RS256",
          "typ": "JWT",
          "kid": kid,
        });



    return jwt.sign(
      RSAPrivateKey(_privateKeyPem!),
      algorithm: JWTAlgorithm.RS256,
    );
  }
}
