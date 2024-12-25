import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_persistence_sqlite/db/database_helper.dart';
import 'package:flutter_persistence_sqlite/models/cat.dart';
import 'package:gap/gap.dart';

class AddCatPage extends StatefulWidget {
  const AddCatPage({super.key});

  @override
  State<AddCatPage> createState() => _AddCatPageState();
}

class _AddCatPageState extends State<AddCatPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  void addCat() {
    final name = nameController.text;
    final age = int.tryParse(ageController.text) ?? 0;

    final cat = Cat(id: 0, name: name, age: age);
    DatabaseHelper().insertCat(cat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          DInputMix(
            title: 'Name',
            hint: 'Enter cat name',
            controller: nameController,
          ),
          Gap(16),
          DInputMix(
            title: 'Age',
            hint: 'Enter cat age',
            controller: ageController,
          ),
          Gap(24),
          FilledButton(
            onPressed: addCat,
            child: Text('Add Cat'),
          ),
        ],
      ),
    );
  }
}
