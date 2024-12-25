import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_persistence_sqlite/db/database_helper.dart';
import 'package:flutter_persistence_sqlite/models/cat.dart';
import 'package:gap/gap.dart';

class UpdateCatPage extends StatefulWidget {
  const UpdateCatPage({super.key, required this.oldCat});
  final Cat oldCat;

  @override
  State<UpdateCatPage> createState() => _UpdateCatPageState();
}

class _UpdateCatPageState extends State<UpdateCatPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  void updateCat() {
    final name = nameController.text;
    final age = int.tryParse(ageController.text) ?? 0;

    final cat = Cat(id: widget.oldCat.id, name: name, age: age);
    DatabaseHelper().updateCat(cat);
  }

  @override
  void initState() {
    nameController.text = widget.oldCat.name;
    ageController.text = widget.oldCat.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Cat'),
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
            onPressed: updateCat,
            child: Text('Update Cat'),
          ),
        ],
      ),
    );
  }
}
