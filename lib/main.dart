import 'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/video_call_screen.dart';
import 'package:untitled/services/auth_methods.dart';
import 'package:untitled/utils/colours.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,

      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: AuthMethods().authChanges, builder: (context,snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){ // this means we didnt have the data yet so its loading
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasData ){
          return const HomeScreen();
        }
        return LoginScreen();

      }),
      routes:   {
        '/login':(context)=> LoginScreen(),
        '/home-screen':(context)=>HomeScreen(),
        '/video-call':(context)=>VideoCallScreen(),
      },
    );
  }
}
