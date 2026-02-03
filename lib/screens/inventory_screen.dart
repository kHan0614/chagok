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

  void addProject() {
    setState(() {
      projects.add('프로젝트 ${projects.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('인벤토리')),
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
            onTap: addProject,
          ),
        ],
      ),
    );
  }
}
