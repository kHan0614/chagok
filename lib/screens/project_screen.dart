import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  final String projectName;

  const ProjectScreen({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(projectName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('추가'),
                SizedBox(width: 12),
                Text('삭제'),
                SizedBox(width: 12),
                Text('변경'),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              '알림',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('부족한 재고'),
                  Divider(),
                  Text('겹치는 재고'),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              '나의 재고',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: const Center(
                  child: Text('재고 리스트 영역'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
