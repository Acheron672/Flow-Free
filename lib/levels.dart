import 'package:flutter/material.dart';
import 'game_data.dart';
import 'game_screen.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = GameData.getLevels();
    
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Выберите уровень'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Легкие'),
              Tab(text: 'Средние'),
              Tab(text: 'Сложные'),
              Tab(text: 'Эксперт'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLevelsGrid(levels.where((l) => l.difficulty == "easy").toList(), context),
            _buildLevelsGrid(levels.where((l) => l.difficulty == "medium").toList(), context),
            _buildLevelsGrid(levels.where((l) => l.difficulty == "hard").toList(), context),
            _buildLevelsGrid(levels.where((l) => l.difficulty == "expert").toList(), context),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelsGrid(List<GameLevel> levels, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];
        return LevelButton(
          level: level,
          onPressed: () {
            if (!level.isLocked) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(level: level),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class LevelButton extends StatelessWidget {
  final GameLevel level;
  final VoidCallback onPressed;

  const LevelButton({
    super.key,
    required this.level,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: _getLevelColor(level),
          borderRadius: BorderRadius.circular(10),
          border: level.isCompleted 
              ? Border.all(color: Colors.green, width: 3)
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    level.id.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  if (level.isLocked)
                    const Icon(Icons.lock, size: 16, color: Colors.white),
                ],
              ),
            ),
            if (level.isCompleted)
              Positioned(
                bottom: 5,
                right: 5,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, 
                        color: level.stars >= 1 ? Colors.yellow : Colors.grey, 
                        size: 12),
                    Icon(Icons.star, 
                        color: level.stars >= 2 ? Colors.yellow : Colors.grey, 
                        size: 12),
                    Icon(Icons.star, 
                        color: level.stars >= 3 ? Colors.yellow : Colors.grey, 
                        size: 12),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(GameLevel level) {
    if (level.isLocked) return Colors.grey;
    
    switch (level.difficulty) {
      case "easy": return Colors.green;
      case "medium": return Colors.blue;
      case "hard": return Colors.orange;
      case "expert": return Colors.red;
      default: return Colors.purple;
    }
  }
}