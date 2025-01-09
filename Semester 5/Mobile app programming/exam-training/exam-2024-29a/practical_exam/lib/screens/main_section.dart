// ignore_for_file: library_private_types_in_public_api, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/database/database_helper.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:practical_exam/screens/add_entity.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';

class MainSection extends StatefulWidget {
  final bool online;

  const MainSection({Key? key, required this.online}) : super(key: key);

  @override
  _MainSectionState createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  late List<Entity> entities = [];
  bool isLoading = false;

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
          .getAll()
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee section'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: ListTile(
                        title: Text(entities[index].toString()),
                        onTap: () {
                          //Handle onTap action
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: entities.length,
                  padding: const EdgeInsets.all(10),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                ))
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.online) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEntity()),
            ).then((value) {
              if (value != null && value is Entity) {
                setState(() {
                  saveEntity(value);
                });
              }
            });
          } else {
            popUpDialog(context, "Error", "Operation not available offline");
          }
        },
        tooltip: 'Add entity',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> saveEntity(Entity entity) async {
    setState(() {
      isLoading = true;
    });

    try {
      final received = await ApiService.instance
          .addEntity(entity)
          .timeout(Duration(seconds: 2));
      DatabaseHelper.addEntity(entity);
      entities.add(entity);
    } catch (e) {
      popUpDialog(context, "Error", "Error connecting to the server");
    }

    setState(() {
      isLoading = false;
    });
  }
}
