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
  static final String? _privateKeyPem ='''
  -----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCVjxHg0TljvygJ
7z2NnN6kuf3tJDOPG6kAvNZJ6kUtccENFJnM7iSQcMM4giEylUWyOiBpL0ogQf/f
KqsmGrR2cXXGYbRDZt5yVGv1BbIj2BnQN08VHzsszP0C3ZPiBnzALnUUbE2NBBsB
FEgoLWbq3w6HyFS/GLU3x1BcHGb+T018mkH5tDlWdWzv/21W3jPCtrmNyhoG4EHx
ycmTXEE0uDFkCT8VkZghytUKKa7dt4y+ku34xhGLsVJESTh4hfZR+eHGA+GINjj8
gqx/0SUS1pjK1amHKZk+8Pmwtoh3BS3QWKMoScll4nTlltqIasfpM/bm51/guVr0
Qr0L3B7/AgMBAAECggEAXRd9wFtbBoxgxrZEsRX4u74NoYNMGILWEmB4Xe/VeXD6
AkNVbGq7FbEqwsy1D0A87rAhpndKA4QxWV68w24R8Du1XHNKej3Yrn9/5zbRaGBF
yQX0Uqhq8/rwbc0wFJuHITSJqdmz99ebW3OdamzAR+fpqnj2zy/49Kw6h+sh7J7K
eVkRDJ97GdpsMbEfkSoxQL1eSUC3emSg9PO4UwphV0PBvUofBzYIHobwyS8Pxevk
SB8nfp+VoPkmMsIMJUmEC4QWCVvHgf8AHGv7XrglD/rzYwOLSG+X3JAlHIM4nS1b
R09sCroTCXPVPBecRXiP80DgyP8zyVjuC6yXhaOrEQKBgQDFihhGSm8SLiYAWpTK
2pEiAT0q3LErq+0u45EkkPeTib13dWR+PvPcIsmXDWymLzT+NlyWMtOizkr2fHGT
6GK/5Iub/q1APVb/PCOqHXo7BAxq1f+X+gNEKI3o2E1f/PqMVVyeOst6Vv2ryQ51
+nKckUNSM6MWM4XM8KOPhg2mFwKBgQDB0ePfn0bPuuxp900YCbxGwoGj4wajsaVk
nZ7VoLjOd2GDnEVmZ7HdRz/AVJXEkQq8WAG7Er9EIaKItuP0xOrX3EaOpEchVBGc
kgmzRqX88LLAHXIqZx7WY368peCuoJ+/l79RzxmZhV8OB8ljAqCY3b/ICfOVyio9
Qyuv3XtHWQKBgD369WDgq/cFWdEUmskHSTBlOR8AvepY+IOUzY6uma/GMReRUuW1
tOgmViA6CxQdjcARqH1MF1Fm7uhl5XEmIg3ZlOBuSUf1tx1AbmRK+XYY8Bh5asfx
nyK8osIjVCvBAZAUnIndIskREGjdHddwrJNplLjvEMW/hsTl4DwBMLkjAoGBAIvE
a+sq1MmgJjQUHggjnR35zbr9UCBjTr3L3Gp5SEu7Uxqxamp6hIzpgFOVq5rgbTl8
zWK2Fi9vgeHM4X31MtUPB+J9HL4v/bNGrLAXVkOc34oisd1aF6bKgO5RQEEtm4Vy
TIkWK4PF5dIcU2GO13jlEBOU+Y8fBm6/LZXYxbmhAoGAH3JrWXDWIUMsZDhB0x/J
VRHSUpuDLV78Cm5l3VXu0hA1/eDn4CGH6gXcvhBkjJRj/Xuypa01EGjSXjpSlKKd
H0kPVgshpOxTaMaHuhMltYIQL3riPmjf9/ClMUT82CHKH2liBkbfx4SWt3DZWl01
0+rWq22B9IPKEHpi/kmUNyQ=
-----END PRIVATE KEY-----
  ''';
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
