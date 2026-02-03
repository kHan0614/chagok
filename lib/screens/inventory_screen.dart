import 'package:flutter/material.dart';
import '../widgets/project_card.dart';
import 'project_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<String> projects = [];

  void addProjectWithName() {
    final controller = TextEditingController(
      text: '창고 ${projects.length + 1}',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('새 창고 만들기'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: '창고 이름',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('이름을 입력하세요')),
                  );
                  return;
                }

                if (projects.contains(name)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('이미 존재하는 창고 이름입니다')),
                  );
                  return;
                }

                setState(() {
                  projects.add(name);
                });

                Navigator.pop(context);
              },
              child: const Text('생성'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나만의 작은 공간')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          ...projects.map(
                (name) => ProjectCard(
              title: name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectScreen(projectName: name),
                  ),
                );
              },
            ),
          ),

          ProjectCard(
            title: '',
            isAdd: true,
            onTap: addProjectWithName, // 👈 여기 변경
          ),
        ],
      ),
    );
  }
}
