import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/authenticate.dart';
import 'package:flutter_chat_app/helper/helper_function.dart';
import 'package:flutter_chat_app/views/chat_screens.dart';

// dont run in debug mode
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAMovo65frIBZaLdyr33ftNTKcsVgrLf-I",
      appId: "1:759281857099:android:1743519241f6b673fc13ce",
      messagingSenderId: "759281857099",
      projectId: "flutter-chat-eeae9",
    ),
  );
  runApp(const MyApp());
}

initFlutter() {}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? userIsLoggedIn;
  @override
  void initState() {
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((val) {
      setState(() {
        userIsLoggedIn = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ignore: unnecessary_null_comparison
      home: userIsLoggedIn != null ? const ChatRoom() : const Authenticate(),
    );
  }
}
// 1 mint cechk krty hn