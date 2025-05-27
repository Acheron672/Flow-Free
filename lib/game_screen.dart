// game_screen.dart
import 'package:flutter/material.dart';
import 'game_data.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  final GameLevel level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<int>> grid;
  late List<List<int>> originalGrid;
  late int selectedColor;
  late List<Offset> currentPath;
  late Map<int, List<Offset>> completedPaths;
  late Stopwatch _stopwatch;
  late Duration _levelTime;
  Timer? _timer;
  bool _levelCompleted = false;
  Offset? _lastCell;
  bool _isDragging = false;
  Offset? _pointerPosition;

@override
void initState() {
  super.initState();
  _stopwatch = Stopwatch();
  _levelTime = Duration.zero;
  _resetGame();
}
@override
void dispose() {
  _stopwatch.stop();
  _timer?.cancel();
  super.dispose();
}

void _startTimer() {
  _stopwatch.reset();
  _stopwatch.start();
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      _levelTime = _stopwatch.elapsed;
    });
  });
}

void _stopTimer() {
  _stopwatch.stop();
  _timer?.cancel();
}

// В методе _checkLevelCompletion обновите:

int _calculateStars(Duration time) {
  // Базовое время для каждого размера уровня
  final baseTime = widget.level.width * widget.level.height;
  
  // Множители сложности
  final difficultyMultiplier = {
    "easy": 1.0,
    "medium": 1.5,
    "hard": 2.0,
    "expert": 3.0,
  }[widget.level.difficulty] ?? 1.5;
  
  // Пороговое время в секундах
  final thresholdSeconds = baseTime * difficultyMultiplier;
  final threshold = Duration(seconds: thresholdSeconds.toInt());
  
  // 3 звезды - меньше половины порога
  // 2 звезды - меньше порога
  // 1 звезда - больше порога
  if (time < threshold ~/ 2) return 3;
  if (time < threshold) return 2;
  return 1;
}

  void _resetGame() {
  originalGrid = widget.level.grid.map((row) => List<int>.from(row)).toList();
  grid = originalGrid.map((row) => List<int>.from(row)).toList();
  selectedColor = 0;
  currentPath = [];
  completedPaths = {};
  _levelCompleted = false;
  _lastCell = null;
  _isDragging = false;
  _pointerPosition = null;
  _stopTimer();
  _startTimer();
  }

  void _resetLevel() {
    setState(_resetGame);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cellSize = (size.width * 0.9) / widget.level.width;

    return Scaffold(
appBar: AppBar(
  title: Text(widget.level.name),
  backgroundColor: Colors.blue[800],
  actions: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '${_levelTime.inMinutes.toString().padLeft(2, '0')}:'
          '${(_levelTime.inSeconds % 60).toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
    IconButton(
      icon: const Icon(Icons.refresh, color: Colors.white),
      onPressed: _resetLevel,
    ),
  ],
),
      body: Container(
        color: Colors.grey[100],
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGrid(cellSize),
                  const SizedBox(height: 20),
                  _buildColorSelector(),
                ],
              ),
            ),
            if (_levelCompleted)
              _buildLevelCompleteOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(double cellSize) {
    return Listener(
      onPointerDown: (details) => _handlePointerDown(details, cellSize),
      onPointerMove: (details) => _handlePointerMove(details, cellSize),
      onPointerUp: (details) => _handlePointerUp(),
      onPointerCancel: (details) => _handlePointerUp(),
      child: Container(
        width: cellSize * widget.level.width,
        height: cellSize * widget.level.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue[800]!, width: 2),
        ),
        child: Stack(
          children: [
            // Grid lines
            CustomPaint(
              painter: _GridPainter(
                width: widget.level.width,
                height: widget.level.height,
                cellSize: cellSize,
              ),
            ),

            // Completed paths
            ...completedPaths.entries.map((entry) => CustomPaint(
              painter: _LinePainter(
                path: entry.value,
                color: _getColorForNumber(entry.key),
                cellSize: cellSize,
                isCompleted: true,
              ),
            )),

            // Current path with pointer tracking
            if (_isDragging && currentPath.isNotEmpty)
              CustomPaint(
                painter: _LinePainter(
                  path: _getExtendedPath(cellSize),
                  color: _getColorForNumber(selectedColor),
                  cellSize: cellSize,
                  isCompleted: false,
                ),
              ),

            // Dots
            for (int y = 0; y < widget.level.height; y++)
              for (int x = 0; x < widget.level.width; x++)
                if (originalGrid[y][x] > 0)
                  Positioned(
                    left: x * cellSize,
                    top: y * cellSize,
                    child: Container(
                      width: cellSize,
                      height: cellSize,
                      alignment: Alignment.center,
                      child: Container(
                        width: cellSize * 0.7,
                        height: cellSize * 0.7,
                        decoration: BoxDecoration(
                          color: _getColorForNumber(originalGrid[y][x]),
                          borderRadius: BorderRadius.circular(cellSize * 0.35),
                          border: Border.all(
                            color: Colors.white,
                            width: cellSize * 0.1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                         ), ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector() {
    final colors = _getAvailableColors();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: colors.map((color) {
          return GestureDetector(
            onTap: () => setState(() => selectedColor = color),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _getColorForNumber(color),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selectedColor == color ? Colors.white : Colors.transparent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
              ),],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

Widget _buildLevelCompleteOverlay() {
  final stars = _calculateStars(_levelTime);
  final threshold = _getThresholdTime();
  final nextLevelId = widget.level.id + 1;
  final hasNextLevel = GameData.levels.any((level) => level.id == nextLevelId);

  return Container(
    color: Colors.black54,
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Уровень пройден!',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Отображение времени
            Text(
              'Ваше время: ${_formatDuration(_levelTime)}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // Лучшее время
            if (widget.level.bestTime != Duration.zero)
              Text(
                'Лучшее время: ${_formatDuration(widget.level.bestTime)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            const SizedBox(height: 20),
            
            // Отображение звезд с пояснениями
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStarInfo(1, stars, threshold ~/ 2),
                const SizedBox(width: 10),
                _buildStarInfo(2, stars, threshold),
                const SizedBox(width: 10),
                _buildStarInfo(3, stars, threshold ~/ 3),
              ],
            ),
            const SizedBox(height: 30),
            
            // Кнопка следующего уровня или возврата
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                hasNextLevel ? 'Следующий уровень' : 'Вернуться к уровням',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            
            // Кнопка переиграть
            TextButton(
              onPressed: _resetLevel,
              child: const Text(
                'Переиграть уровень',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStarInfo(int starNumber, int earnedStars, Duration targetTime) {
  final hasStar = earnedStars >= starNumber;
  return Column(
    children: [
      Icon(
        Icons.star,
        color: hasStar ? Colors.yellow : Colors.grey,
        size: 40,
      ),
      const SizedBox(height: 5),
      Text(
        '${_formatDuration(targetTime)}',
        style: TextStyle(
          fontSize: 14,
          color: hasStar ? Colors.yellow : Colors.grey,
        ),
      ),
    ],
  );
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

Duration _getThresholdTime() {
  // Базовое время в секундах (настраивайте по желанию)
  final baseTime = widget.level.width * widget.level.height;
  
  // Множитель сложности
  final difficultyMultiplier = {
    'easy': 1.0,
    'medium': 1.5,
    'hard': 2.0,
    'expert': 3.0,
  }[widget.level.difficulty] ?? 1.5;
  
  return Duration(seconds: (baseTime * difficultyMultiplier).toInt());
}

  List<Offset> _getExtendedPath(double cellSize) {
    if (_pointerPosition == null) return currentPath;
    
    final lastPoint = currentPath.last;
    final pointerX = _pointerPosition!.dx / cellSize;
    final pointerY = _pointerPosition!.dy / cellSize;
    
    return [...currentPath, Offset(pointerX, pointerY)];
  }

  void _handlePointerDown(PointerDownEvent event, double cellSize) {
    final x = (event.localPosition.dx / cellSize).floor();
    final y = (event.localPosition.dy / cellSize).floor();
    
    if (x >= 0 && x < widget.level.width && y >= 0 && y < widget.level.height) {
      if (originalGrid[y][x] > 0) {
        setState(() {
          // Remove any existing path for this color
          if (completedPaths.containsKey(originalGrid[y][x])) {
            _clearPath(originalGrid[y][x]);
          }
          
          selectedColor = originalGrid[y][x];
          currentPath = [Offset(x + 0.5, y + 0.5)];
          _lastCell = Offset(x.toDouble(), y.toDouble());
          _isDragging = true;
          _pointerPosition = event.localPosition;
        });
      }
    }
  }

  void _handlePointerMove(PointerMoveEvent event, double cellSize) {
    if (!_isDragging || selectedColor == 0) return;
    
    final x = (event.localPosition.dx / cellSize).floor();
    final y = (event.localPosition.dy / cellSize).floor();
    
    setState(() {
      _pointerPosition = event.localPosition;
    });
    
    if (x >= 0 && x < widget.level.width && y >= 0 && y < widget.level.height) {
      final currentCell = Offset(x.toDouble(), y.toDouble());
      if (_lastCell != currentCell) {
        setState(() {
          _lastCell = currentCell;
          
          // Check if moving to previous cell
          if (currentPath.length > 1 && currentPath[currentPath.length - 2] == Offset(x + 0.5, y + 0.5)) {
            // Undo last move
            final last = currentPath.last;
            grid[(last.dy - 0.5).toInt()][(last.dx - 0.5).toInt()] = 0;
            currentPath.removeLast();
          } 
          // Check if moving to valid empty cell or same color dot
          else if (grid[y][x] == 0 || originalGrid[y][x] == selectedColor) {
            // Check if adjacent horizontally or vertically (no diagonals)
            final lastX = (currentPath.last.dx - 0.5).toInt();
            final lastY = (currentPath.last.dy - 0.5).toInt();
            
            // Only allow horizontal or vertical movement
            bool isHorizontalMove = (x == lastX) && (y - lastY).abs() == 1;
            bool isVerticalMove = (y == lastY) && (x - lastX).abs() == 1;
            
            if (isHorizontalMove || isVerticalMove) {
              grid[y][x] = selectedColor;
              currentPath.add(Offset(x + 0.5, y + 0.5));
            }
          }
        });
      }
    }
  }

  void _handlePointerUp() {
    setState(() {
      if (_isDragging) {
        // Check if we reached another dot of the same color
        if (currentPath.length > 1) {
          final startX = (currentPath.first.dx - 0.5).toInt();
          final startY = (currentPath.first.dy - 0.5).toInt();
          final endX = (currentPath.last.dx - 0.5).toInt();
          final endY = (currentPath.last.dy - 0.5).toInt();
          
          if (originalGrid[startY][startX] == originalGrid[endY][endX]) {
            // Valid path completed
            completedPaths[selectedColor] = List.from(currentPath);
            _fillPath(selectedColor, currentPath);
          } else {
            // Invalid path - reset
            _clearPath(selectedColor);
          }
        } else {
          // Single point - reset
          _clearPath(selectedColor);
        }
        
        currentPath = [];
        _isDragging = false;
        _pointerPosition = null;
        _checkLevelCompletion();
      }
    });
  }

  void _fillPath(int color, List<Offset> path) {
    // Reset grid to original state
    grid = originalGrid.map((row) => List<int>.from(row)).toList();
    
    // Fill all completed paths
    for (final entry in completedPaths.entries) {
      for (final point in entry.value) {
        final x = (point.dx - 0.5).toInt();
        final y = (point.dy - 0.5).toInt();
        if (grid[y][x] == 0) {
          grid[y][x] = entry.key;
        }
      }
    }
  }

  void _clearPath(int color) {
    completedPaths.remove(color);
    _fillPath(color, []);
  }
void _checkLevelCompletion() {
  bool completed = true;
  for (var row in grid) {
    for (var cell in row) {
      if (cell == 0) {
        completed = false;
        break;
      }
    }
    if (!completed) break;
  }
  
  if (completed) {
    _stopTimer();
    final time = _stopwatch.elapsed;
    // Calculate stars (1-3) based on time
    int stars = _calculateStars(time);
    
    // Update level stats
    GameData.updateLevelStats(widget.level.id, stars, time);
    
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _levelCompleted = true;
      });
    });
  }
}


  Color _getColorForNumber(int number) {
    const colors = [
      Color(0xFFF44336), // Red
      Color(0xFF2196F3), // Blue
      Color(0xFF4CAF50), // Green
      Color(0xFFFFEB3B), // Yellow
      Color(0xFF9C27B0), // Purple
      Color(0xFFFF9800), // Orange
      Color(0xFFE91E63), // Pink
      Color(0xFF009688), // Teal
      Color(0xFF3F51B5), // Indigo
      Color(0xFF795548), // Brown
      Color.fromARGB(255, 255, 91, 255), 
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 150, 255, 203), 
      Color.fromARGB(255, 136, 148, 26), 
    ];
    return colors[number % colors.length];
  }

  List<int> _getAvailableColors() {
    final colors = <int>{};
    for (var row in originalGrid) {
      for (var cell in row) {
        if (cell > 0) colors.add(cell);
      }
    }
    return colors.toList()..sort();
  }
}

class _GridPainter extends CustomPainter {
  final int width;
  final int height;
  final double cellSize;

  _GridPainter({
    required this.width,
    required this.height,
    required this.cellSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Vertical lines
    for (int x = 1; x < width; x++) {
      canvas.drawLine(
        Offset(x * cellSize, 0),
        Offset(x * cellSize, height * cellSize),
        paint,
      );
    }

    // Horizontal lines
    for (int y = 1; y < height; y++) {
      canvas.drawLine(
        Offset(0, y * cellSize),
        Offset(width * cellSize, y * cellSize),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return width != oldDelegate.width || height != oldDelegate.height;
  }
}

class _LinePainter extends CustomPainter {
  final List<Offset> path;
  final Color color;
  final double cellSize;
  final bool isCompleted;

  _LinePainter({
    required this.path,
    required this.color,
    required this.cellSize,
    this.isCompleted = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (path.length < 2) return;

    final paint = Paint()
      ..color = color.withOpacity(isCompleted ? 1.0 : 0.7)
      ..strokeWidth = cellSize * 0.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (isCompleted) {
      paint
        ..strokeWidth = cellSize * 0.45
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    }

    final pathToDraw = Path();
    pathToDraw.moveTo(path[0].dx * cellSize, path[0].dy * cellSize);

    for (int i = 1; i < path.length; i++) {
      pathToDraw.lineTo(path[i].dx * cellSize, path[i].dy * cellSize);
    }

    canvas.drawPath(pathToDraw, paint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) {
    return path != oldDelegate.path || 
           color != oldDelegate.color || 
           isCompleted != oldDelegate.isCompleted;
  }
}