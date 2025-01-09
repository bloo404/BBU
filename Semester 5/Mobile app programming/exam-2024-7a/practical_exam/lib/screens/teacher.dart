import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/database/database_helper.dart';
import 'package:practical_exam/models/entity.dart';

class TeacherSection extends StatefulWidget {
  const TeacherSection({Key? key});

  @override
  _TeacherSectionState createState() => _TeacherSectionState();
}

class _TeacherSectionState extends State<TeacherSection> {
  Map<String, int> monthlyParticipants = {};
  bool isLoading = false;
  Logger logger = Logger();
  ApiService api = ApiService.instance;

  @override
  void initState() {
    super.initState();
    monthlyParticipants.clear();
    getEntities();
  }

  Future<void> getEntities() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Entity> serverEntities = await ApiService.instance
          .getParticipation()
          .timeout(const Duration(seconds: 2));

      for (var serverEntity in serverEntities) {
        DateTime date = DateTime.parse(serverEntity.date);
        String monthYear = '${date.month}-${date.year}';
        monthlyParticipants.update(monthYear, (value) => value + 1,
            ifAbsent: () => 1);

        await DatabaseHelper.addEntity(serverEntity);
      }
    } catch (e) {
      monthlyParticipants = {};
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher section"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: monthlyParticipants.isNotEmpty
                      ? ListView.builder(
                          itemCount: monthlyParticipants.length,
                          itemBuilder: (context, index) {
                            String monthYear =
                                monthlyParticipants.keys.elementAt(index);
                            int participantCount =
                                monthlyParticipants.values.elementAt(index);

                            return ListTile(
                              title: Text(monthYear),
                              subtitle: Text('$participantCount participants'),
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
