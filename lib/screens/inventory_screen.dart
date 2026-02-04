import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/project_card.dart';
import 'project_screen.dart';

/// TODO: 공용 모델 파일로 분리 가능
class Warehouse {
  final int id;
  final String name;

  Warehouse({required this.id, required this.name});

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'],
      name: json['name'],
    );
  }
}

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Warehouse> warehouses = [];
  bool loading = false;

  /// TODO: 로그인 후 실제 user_id로 교체
  final int userId = 1;

  @override
  void initState() {
    super.initState();
    loadWarehouses();
  }

  /// 📦 창고 목록 불러오기
  Future<void> loadWarehouses() async {
    setState(() => loading = true);
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/warehouse?user_id=$userId'),
      );

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        setState(() {
          warehouses.clear();
          warehouses.addAll(
            (data['warehouses'] as List)
                .map((e) => Warehouse.fromJson(e))
                .toList(),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('창고 목록 로드 실패: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  /// ➕ 창고 생성
  Future<void> createWarehouse(String name) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/warehouse'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'name': name,
        }),
      );

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        loadWarehouses(); // DB 기준으로 다시 로드
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('창고 생성 실패: $e')),
      );
    }
  }

  /// 🧱 다이얼로그
  void addWarehouseDialog() {
    final controller = TextEditingController(
      text: '창고 ${warehouses.length + 1}',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('이름을 입력하세요')),
                );
                return;
              }

              await createWarehouse(name);
              Navigator.pop(context);
            },
            child: const Text('생성'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나만의 작은 공간')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          ...warehouses.map(
                (w) => ProjectCard(
              title: w.name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectScreen(
                      projectName: w.name,
                      // TODO: warehouse_id 전달해서 DB 기반 화면 구성
                    ),
                  ),
                );
              },
            ),
          ),
          ProjectCard(
            title: '',
            isAdd: true,
            onTap: addWarehouseDialog,
          ),
        ],
      ),
    );
  }
}
