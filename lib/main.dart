import 'package:flutter/material.dart';
import 'package:songs/screens/home_page_screen.dart';
import 'package:songs/screens/player_screen.dart';
import 'package:provider/provider.dart';
import './providers/song_provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SongProvider()),
          ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MomoPlayer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith( secondary: Colors.black)
      ),
      home: const HomePageScreen(),
      initialRoute: '/',
      routes: {
        '/player': (context) => const PlayerScreen()
      },
    );

  }
}