import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/api/api.dart';

class ManageSection extends StatefulWidget {
  const ManageSection({super.key});

  @override
  _ManageSectionState createState() => _ManageSectionState();
}

class _ManageSectionState extends State<ManageSection> {
  List<String> entities = [];
  bool isLoading = false;
  Logger logger = Logger();
  ApiService api = ApiService.instance;

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
      List<String> serverEntities = await ApiService.instance
          .getTypes()
          .timeout(const Duration(seconds: 2));

      for (var serverEntity in serverEntities) {
        if (!entities.contains(serverEntity)) {
          entities.add(serverEntity);
        }
      }
    } catch (e) {
      // entities = await DatabaseHelper.getAll();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Section"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: entities.isNotEmpty
                      ? ListView.builder(
                          itemCount: entities.length,
                          itemBuilder: (context, index) {
                            String entity = entities[index];
                            return ListTile(
                              title: Text('$entity'),
                              trailing: InkWell(
                                onTap: () {
                                  api.register(entity);
                                },
                                child: Icon(Icons.add),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("No entities available"),
                        ),
                ),
              ],
            ),
    );
  }
}
