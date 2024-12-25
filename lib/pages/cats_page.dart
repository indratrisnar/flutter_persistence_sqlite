import 'package:flutter/material.dart';
import 'package:flutter_persistence_sqlite/db/database_helper.dart';
import 'package:flutter_persistence_sqlite/models/cat.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({super.key});

  @override
  State<CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  List<Cat> cats = [];

  void fetchCats() {
    DatabaseHelper().fetchCats().then((value) {
      cats = value;
      setState(() {});
    });
  }

  void deleteCat(int id) {
    DatabaseHelper().deleteCat(id).then((value) {
      fetchCats();
    });
  }

  void gotoAddCat() {
    Navigator.pushNamed(
      context,
      '/cat/add',
    ).then((value) {
      fetchCats();
    });
  }

  void gotoUpdateCat(Cat cat) {
    Navigator.pushNamed(
      context,
      '/cat/update',
      arguments: cat,
    ).then((value) {
      fetchCats();
    });
  }

  @override
  void initState() {
    fetchCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
        actions: [
          IconButton.filledTonal(
            icon: Icon(Icons.add),
            onPressed: gotoAddCat,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            horizontalMargin: 16,
            showBottomBorder: true,
            columns: [
              DataColumn(label: Text('Id')),
              DataColumn(
                label: Text('Name'),
                headingRowAlignment: MainAxisAlignment.start,
              ),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Action')),
            ],
            rows: List.generate(cats.length, (index) {
              final cat = cats[index];
              return DataRow(
                cells: [
                  DataCell(
                    Text(cat.id.toString()),
                    showEditIcon: true,
                    onTap: () => gotoUpdateCat(cat),
                  ),
                  DataCell(Text(cat.name)),
                  DataCell(Text(cat.age.toString())),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteCat(cat.id),
                  )),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
