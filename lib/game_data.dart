// game_data.dart
import 'dart:async';
class GameLevel {
  final int id;
  final String name;
  final String difficulty;
  final int width;
  final int height;
  final List<List<int>> grid;
  bool isLocked;
  bool isCompleted;
  int stars; // 0-3 stars for completed level
  Duration bestTime; // Best completion time

GameLevel({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.width,
    required this.height,
    required this.grid,
    this.isLocked = true,
    this.isCompleted = false,
    this.stars = 0,
    this.bestTime = const Duration(),
  });
}

class User {
  final String name;
  final Map<int, int> levelStars; // levelId: stars
  final Map<int, Duration> levelTimes; // levelId: bestTime

  User({
    required this.name,
    Map<int, int>? levelStars,
    Map<int, Duration>? levelTimes,
  })  : levelStars = levelStars ?? {},
        levelTimes = levelTimes ?? {};
}


class GameData {
static List<GameLevel> levels = []; // Add this line to define levels variable

  static List<GameLevel> getLevels() {
    if (levels.isNotEmpty) return levels;
    
    levels = [
// легко....................................................................................................................
      GameLevel(
        id: 1,
        name: "Easy 1",
        difficulty: "easy",
        width: 5,
        height: 5,
        grid: [
          [1, 0, 3, 0, 4].map((e) => e as int).toList(),
          [0, 0, 2, 0, 5].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 3, 0, 4, 0].map((e) => e as int).toList(),
          [0, 1, 2, 5, 0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 2,
        name: "Easy 2",
        difficulty: "easy",
        width: 5,
        height: 5,
        grid: [
          [0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	4,	0,	2,	0].map((e) => e as int).toList(),
          [0,	0,	2,	0,	0].map((e) => e as int).toList(),
          [0,	0,	1,	0,	3].map((e) => e as int).toList(),
          [1,	4,	3,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 3,
        name: "Easy 3",
        difficulty: "easy",
        width: 5,
        height: 5,
        grid: [
          [0,	0,	0,	0,	2].map((e) => e as int).toList(),
          [0,	4,	0,	0,	4].map((e) => e as int).toList(),
          [0,	0,	0,	2,	1].map((e) => e as int).toList(),
          [0,	0,	0,	3,	0].map((e) => e as int).toList(),
          [3,	1,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),


      GameLevel(
        id: 4,
        name: "Easy 4",
        difficulty: "easy",
        width: 6,
        height: 6,
        grid: [
          [0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [2,	1,	4,	5,	0,	0].map((e) => e as int).toList(),
          [1,	0,	0,	3,	0,	0].map((e) => e as int).toList(),
          [3,	0,	0,	0,	0,	2].map((e) => e as int).toList(),
          [0,	4,	0,	0,	5,	6].map((e) => e as int).toList(),
          [0,	0,	0,	6,	0,	0].map((e) => e as int).toList(),
          
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 5,
        name: "Easy 5",
        difficulty: "easy",
        width: 6,
        height: 6,
        grid: [
          [0,	0,	0,	4,	0,	0].map((e) => e as int).toList(),
          [0,	2,	0,	3,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	2,	0,	4].map((e) => e as int).toList(),
          [0,	0,	1,	0,	0,	5].map((e) => e as int).toList(),
          [0,	0,	0,	0,	3,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	1,	5].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),
// средний...........................................................................................................................
      GameLevel(
        id: 6,
        name: "medium 1",
        difficulty: "medium",
        width: 7,
        height: 7,
        grid: [
          [0,	0,	0,	0,	0,	0,	2].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	5,	1].map((e) => e as int).toList(),
          [0,	5,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	3,	6,	0,	0].map((e) => e as int).toList(),
          [0,	0,	3,	0,	4,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	1,	4,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	2,	6].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 7,
        name: "medium 2",
        difficulty: "medium",
        width: 7,
        height: 7,
        grid: [
          [0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	6,	1,	0].map((e) => e as int).toList(),
          [0,	1,	0,	0,	0,	0,	3].map((e) => e as int).toList(),
          [3,	0,	0,	0,	4,	0,	0].map((e) => e as int).toList(),
          [6,	0,	2,	0,	0,	4,	0].map((e) => e as int).toList(),
          [5,	0,	0,	0,	0,	5,	2].map((e) => e as int).toList(),
          
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 8,
        name: "medium 3",
        difficulty: "medium",
        width: 7,
        height: 7,
        grid: [
          [0,	0,	3,	6,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	5,	2,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	4,	1,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	4,	0,	2,	0].map((e) => e as int).toList(),
          [0,	0,	1,	0,	0,	5,	6].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	3].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 9,
        name: "medium 4",
        difficulty: "medium",
        width: 8,
        height: 8,
        grid: [
          [0,	0,	5,	0,	1,	9,	0,	0].map((e) => e as int).toList(),
          [0,	4,	0,	0,	7,	0,	7,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	9].map((e) => e as int).toList(),
          [3,	0,	0,	0,	0,	4,	0,	1].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	6].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	2,	0,	0].map((e) => e as int).toList(),
          [0,	5,	8,	2,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	3,	8,	6,	0,	0].map((e) => e as int).toList(),  
        ],
        isLocked: false,
      ),

      GameLevel(
        id: 10,
        name: "medium 5",
        difficulty: "medium",
        width: 8,
        height: 8,
        grid: [
          [3,	1,	0,	0,	7,	0,	0,	7].map((e) => e as int).toList(),
          [0,	0,	3,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	5,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	2,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	4,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	2,	4,	6,	0,	0].map((e) => e as int).toList(),
          [6,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [5,	0,	1,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
         
      
        ],
        isLocked: false,
      ),
// сложный....................................................................................................................
      GameLevel(
        id: 11,
        name: "hard 1",
        difficulty: "hard",
        width: 9,
        height: 9,
        grid: [
          [0, 0,	0,	0,	0,	0,	1,	6,	3 ].map((e) => e as int).toList(),
          [0,	2,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [8,	0,	0,	1,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	6,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	3,	0,	0,	0,	0,	0,	5,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	7,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	4,	0,	4].map((e) => e as int).toList(),
          [0,	0,	0,	8,	0,	0,	7,	5,	9].map((e) => e as int).toList(),
          [2,	0,	0,	0,	0,	9,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

       GameLevel(
        id: 12,
        name: "hard 2",
        difficulty: "hard",
        width: 9,
        height: 9,
        grid: [
          [0,	2,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	7,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	6,	0,	0].map((e) => e as int).toList(),
          [2,	0,	0,	3,	5,	0,	0,	0,	4].map((e) => e as int).toList(),
          [0,	0,	1,	0,	0,	0,	0,	0,	7].map((e) => e as int).toList(),
          [0,	6,	0,	0,	0,	0,	0,	0,	4].map((e) => e as int).toList(),
          [0,	0,	3,	5,	0,	0,	1,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

       GameLevel(
        id: 13,
        name: "hard 3",
        difficulty: "hard",
        width: 9,
        height: 9,
        grid: [
          [0,	0,	0,	0,	0,	0,	0,	2,	0].map((e) => e as int).toList(),
          [0,	0,	4,	7,	2,	0,	0,	8,	0].map((e) => e as int).toList(),
          [8,	0,	9,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	6,	0].map((e) => e as int).toList(),
          [0,	5,	1,	0,	0,	9,	0,	7,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	1,	0,	4,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	5,	0,	6,	0,	0,	0,	0,	3].map((e) => e as int).toList(),
          [0,	0,	0,	3,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

       GameLevel(
        id: 14,
        name: "hard 4",
        difficulty: "hard",
        width: 10,
        height: 10,
        grid: [
          [1,	0,	0,	0,	0,	2,	0,	0,	0,	2].map((e) => e as int).toList(),
          [0,	0,	0,	11,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	11,	3,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	6,	5,	8,	0,	0,	5,	0,	0,	0].map((e) => e as int).toList(),
          [0,	10,	0,	0,	0,	0,	8,	0,	3,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	12,	0].map((e) => e as int).toList(),
          [0,	0,	1,	0,	0,	7,	0,	0,	0,	6].map((e) => e as int).toList(),
          [4,	12,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	9,	0,	0,	0,	0,	10,	0,	7,	0].map((e) => e as int).toList(),
          [0,	4,	0,	0,	9,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

       GameLevel(
        id: 15,
        name: "hard 5",
        difficulty: "hard",
        width: 10,
        height: 10,
        grid: [
          [0,	0,	0,	0,	0,	0,	0,	8,	0,	7].map((e) => e as int).toList(),
          [0,	6,	2,	0,	0,	6,	0,	0,	0,	4].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	3,	4,	0,	7,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	1,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	3,	0,	0,	5,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	8,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	2,	0,	0,	5,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	1,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),
// эксперт......................................................................................................................
      GameLevel(
        id: 16,
        name: "expert 1",
        difficulty: "expert",
        width: 14,
        height: 14,
        grid: [
          [12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 4, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 14, 0, 0, 1, 0, 0, 1, 5, 0].map((e) => e as int).toList(),
          [0, 6, 0, 0, 0, 9, 12, 0, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 4, 7, 0, 0, 8, 0, 0, 3, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 14, 0, 11, 0, 10, 13, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 5, 0, 0].map((e) => e as int).toList(),
          [0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0].map((e) => e as int).toList(),
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),
            GameLevel(
        id: 17,
        name: "expert 2",
        difficulty: "expert",
        width: 11,
        height: 11,
        grid: [
          [9,	0,	0,	0,	0,	0,	0,	0,	0,	8,	4].map((e) => e as int).toList(),
          [2,	0,	0,	0,	11,	0,	0,	6,	5,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	6,	0,	8,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	9,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	2,	3,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	7,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	5,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	4,	0,	1,	0,	0,	0].map((e) => e as int).toList(),
          [1,	3,	0,	0,	0,	0,	0,	7,	11,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),
            GameLevel(
        id: 18,
        name: "expert 3",
        difficulty: "expert",
        width: 12,
        height: 12,
        grid: [
          [0,	4,	0,	0,	0,	0,	0,	0,	0,	0,	9,  1].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	13,	0,	0,	1,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	13,	0,	0,	0,	0,	0,	9,	10,	0,	0].map((e) => e as int).toList(),
          [0,	6,	7,	0,	0,	11,	0,	0,	0,	0,	11,	0].map((e) => e as int).toList(),
          [0,	0,	0,	6,	5,	8,	3,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	2,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	4,	8,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	7,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	5,	0,	2,	12,	0,	0,	12,	0,	0,	3,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	10,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

            GameLevel(
        id: 19,
        name: "expert 4",
        difficulty: "expert",
        width: 13,
        height: 13,
        grid: [
          [0,	0,	0,	0,	0,	0,  0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [6,	0,	0,	0,	5,	0,	0,	0,	0,	0,	11,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	2,	8,	0,	1,	0,	0,	7,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	7,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	12,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	11,	0,	3,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,  0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,  0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	9,	0,	0,	0,	8,	0,	3,	4,	0,	0,	4,	0].map((e) => e as int).toList(),
          [0,	0,	0,	12,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	9,	0,	0,	5,	0,	0,	0,	0,	0,	2,	6,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),

            GameLevel(
        id: 20,
        name: "expert 5",
        difficulty: "expert",
        width: 14,
        height: 14,
        grid: [
          [12, 0,	0,	0,	0,	0,	0,	0,	0,	0,	7,	4,	0,	0].map((e) => e as int).toList(),
          [0,	 0,	0,	0,	0,	14,	0,	0,	1,	0,	0,	1,	5,	0].map((e) => e as int).toList(),
          [0,	6,	0,	0,	0,	9,	12,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	4,	7,	0,	0,	8,	0,	0,	3,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	14,	0,	11,	0,	10,	13,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	6,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	11,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	9,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	2,	0,	2,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	13,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	8,	0,	0,	5,	0,	0].map((e) => e as int).toList(),
          [0,	10,	0,	0,	0,	0,	0,	0,	0,	0,	0,	3,	0,	0].map((e) => e as int).toList(),
          [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0].map((e) => e as int).toList(),
        ],
        isLocked: false,
      ),
    ];
   return levels;
  }
  static List<User> users = [];
  static User? currentUser;

  static void updateLevelStats(int levelId, int stars, Duration time) {
    final level = levels.firstWhere((l) => l.id == levelId);
    level.isCompleted = true;
    level.isLocked = false;
    
    if (stars > level.stars) {
      level.stars = stars;
    }
    
    if (time < level.bestTime || level.bestTime == Duration.zero) {
      level.bestTime = time;
    }
    
    // Unlock next level
    if (levelId < levels.length) {
      final nextLevel = levels.firstWhere((l) => l.id == levelId + 1);
      nextLevel.isLocked = false;
    }
    
    if (currentUser != null) {
      currentUser!.levelStars[levelId] = stars;
      currentUser!.levelTimes[levelId] = time;
    }
  }

  static void addUser(String name) {
    users.add(User(name: name));
    currentUser = users.last;
  }

  static List<User> getLeaderboard() {
    return List.from(users)
      ..sort((a, b) {
        final aStars = a.levelStars.values.fold(0, (sum, stars) => sum + stars);
        final bStars = b.levelStars.values.fold(0, (sum, stars) => sum + stars);
        return bStars.compareTo(aStars);
      });
  }
}



