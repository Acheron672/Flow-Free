// main.dart
import 'package:flutter/material.dart';
import 'levels.dart';
import 'user_screen.dart';

void main() {
  runApp(const FlowFreeApp());
}

class FlowFreeApp extends StatelessWidget {
  const FlowFreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flow Free',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Flow Free',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserScreen()),
                );
              },
              child: const Text(
                'Профиль',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelsScreen()),
                );
              },
              child: const Text(
                'Начать игру',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                _showHowToPlayDialog(context);
              },
              child: const Text(
                'Как играть',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHowToPlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Как играть'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Цель игры:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Соедините точки одного цвета линиями, чтобы заполнить все клетки на поле.'),
                SizedBox(height: 10),
                Text(
                  'Правила:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('1. Линии не должны пересекаться'),
                Text('2. Линии должны заполнять все пустые клетки'),
                Text('3. Используйте логику, чтобы решить головоломку!'),
                SizedBox(height: 10),
                Text(
                  'Уровни:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(' Легкие'),
                Text(' Средние'),
                Text(' Сложные'),
                Text(' Эксперт'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}