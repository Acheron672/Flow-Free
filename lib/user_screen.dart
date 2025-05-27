// user_screen.dart
import 'package:flutter/material.dart';
import 'game_data.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _nameSet = false;

  @override
  void initState() {
    super.initState();
    _nameSet = GameData.currentUser != null;
    if (_nameSet) {
      _nameController.text = GameData.currentUser!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль и рейтинг'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (!_nameSet) _buildNameInput(),
              if (_nameSet) _buildUserInfo(),
              const SizedBox(height: 20),
              _buildLeaderboard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Введите ваше имя',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.trim().isNotEmpty) {
              GameData.addUser(_nameController.text.trim());
              setState(() {
                _nameSet = true;
              });
            }
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

// В _buildUserInfo добавьте кнопку выхода:
Widget _buildUserInfo() {
  final user = GameData.currentUser!;
  final totalStars = user.levelStars.values.fold(0, (sum, stars) => sum + stars);
  final completedLevels = user.levelStars.length;

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Звезды'),
                  Text(
                    '$totalStars',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Уровни'),
                  Text(
                    '$completedLevels',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                GameData.currentUser = null;
                _nameSet = false;
                _nameController.clear();
              });
            },
            child: const Text('Сменить пользователя'),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildLeaderboard() {
    final leaderboard = GameData.getLeaderboard();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Рейтинг игроков',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (leaderboard.isEmpty)
          const Text('Пока нет данных о рейтинге')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final user = leaderboard[index];
              final totalStars = user.levelStars.values.fold(0, (sum, stars) => sum + stars);
              
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text(user.name),
                trailing: Text('$totalStars ★'),
                tileColor: user == GameData.currentUser 
                    ? Colors.blue.withOpacity(0.1)
                    : null,
              );
            },
          ),
      ],
    );
  }
}