import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isAdd;

  const ProjectCard({
    super.key,
    required this.title,
    required this.onTap,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isAdd ? Colors.grey.shade200 : null,
        child: Center(
          child: isAdd
              ? const Icon(Icons.add, size: 40)
              : Text(title),
        ),
      ),
    );
  }
}
