import 'package:rufus_player/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:rufus_player/palette.dart' as palette;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: palette.secondarybg));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rufus Player',
      theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: palette.highlight)),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
