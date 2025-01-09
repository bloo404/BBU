import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/database/database_helper.dart';
import 'package:practical_exam/models/entity.dart';

class ManageSection extends StatefulWidget {
  const ManageSection({Key? key}) : super(key: key);

  @override
  _ManageSectionState createState() => _ManageSectionState();
}

class _ManageSectionState extends State<ManageSection> {
  List<Entity> entities = [];
  List<Entity> filteredEntities = [];
  bool isLoading = false;
  Logger logger = Logger();
  ApiService api = ApiService.instance;
  TextEditingController searchController = TextEditingController();

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
      List<Entity> serverEntities =
          await api.search().timeout(const Duration(seconds: 2));

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
      filteredEntities = List.from(entities);
    });
  }

  void filterList(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredEntities = List.from(entities);
      } else {
        filteredEntities = entities
            .where((entity) =>
                entity.breed.toLowerCase().contains(query.toLowerCase()) ||
                entity.age.toString().contains(query) ||
                entity.location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void sortList() {
    filteredEntities.sort((a, b) {
      if (a.weight == b.weight) {
        return a.age.compareTo(b.age);
      }
      return b.weight.compareTo(a.weight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Section"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      filterList(query);
                      sortList();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search (Breed, Age, Location)',
                    ),
                  ),
                ),
                Expanded(
                  child: filteredEntities.isNotEmpty
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
                          child: Text("No entities available"),
                        ),
                ),
              ],
            ),
    );
  }
}
