import 'package:flutter/material.dart';

class ItemAddScreen extends StatefulWidget {
  const ItemAddScreen({super.key});

  @override
  State<ItemAddScreen> createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _unitController = TextEditingController(text: 'pcs');
  final _minQtyController = TextEditingController(text: '0');

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _unitController.dispose();
    _minQtyController.dispose();
    super.dispose();
  }

  void _saveItem() {
    final name = _nameController.text.trim();
    final sku = _skuController.text.trim();
    final unit = _unitController.text.trim();
    final minQty = int.tryParse(_minQtyController.text) ?? 0;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이템 이름은 필수입니다')),
      );
      return;
    }

    // TODO: API 호출
    print({
      'name': name,
      'sku': sku,
      'unit': unit,
      'min_quantity': minQty,
    });

    Navigator.pop(context); // 저장 후 이전 화면
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('아이템 추가')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '아이템 이름',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _skuController,
              decoration: const InputDecoration(
                labelText: 'SKU (선택)',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _unitController,
              decoration: const InputDecoration(
                labelText: '단위',
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _minQtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '최소 수량',
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveItem,
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
