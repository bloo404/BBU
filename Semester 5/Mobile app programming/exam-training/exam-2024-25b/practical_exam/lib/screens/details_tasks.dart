import 'package:flutter/material.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/database/database_helper.dart';

class DetailsTask extends StatefulWidget {
  final String selectedDate;

  const DetailsTask({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _DetailsTaskState createState() => _DetailsTaskState();
}

class _DetailsTaskState extends State<DetailsTask> {
  List<Entity> entities = [];
  bool isLoading = false;
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    getEntities();
  }

  Future<void> getEntities() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Entity> serverEntities = await ApiService.instance
          .getEntries()
          .timeout(const Duration(seconds: 2));

      for (var serverEntity in serverEntities) {
        if (!entities.contains(serverEntity)) {
          await DatabaseHelper.addEntity(serverEntity);
          entities.add(serverEntity);
        }
      }
    } catch (e) {
      entities = await DatabaseHelper.getAll();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Entity> filteredEntities =
        entities.where((entity) => entity.date == widget.selectedDate).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Details for ${widget.selectedDate}"),
      ),
      body: filteredEntities.isNotEmpty
          ? ListView.builder(
              itemCount: filteredEntities.length,
              itemBuilder: (context, index) {
                Entity entity = filteredEntities[index];
                return ListTile(
                  title: Text(entity.toString()),
                );
              },
            )
          : const Center(
              child: Text("No entities available for the selected date"),
            ),
    );
  }
}
