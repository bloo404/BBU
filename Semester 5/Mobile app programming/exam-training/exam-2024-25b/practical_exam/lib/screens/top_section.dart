import 'package:flutter/material.dart';
import 'package:practical_exam/api/api.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';

class TopSection extends StatefulWidget {
  final bool online;

  const TopSection({Key? key, required this.online}) : super(key: key);

  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  bool isLoading = false;
  ApiService api = ApiService.instance;
  List<MapEntry<String, int>> top3Categories = [];

  @override
  void initState() {
    super.initState();
    getTopCategories();
  }

  Future<void> getTopCategories() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Entity> serverEntities =
          await api.getAll().timeout(const Duration(seconds: 2));

      Map<String, int> categoryCounts = {};
      for (Entity entity in serverEntities) {
        categoryCounts[entity.category] =
            (categoryCounts[entity.category] ?? 0) + 1;
      }

      List<MapEntry<String, int>> sortedCategories = categoryCounts.entries
          .toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      top3Categories = sortedCategories.take(3).toList();
    } catch (e) {
      // ignore: use_build_context_synchronously
      popUpDialog(context, "Error", "Something went wrong.");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Categories'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: top3Categories.length,
              itemBuilder: (context, index) {
                var entry = top3Categories[index];
                return ListTile(
                  title: Text("Category: ${entry.key}"),
                  subtitle: Text("Tasks: ${entry.value}"),
                );
              },
            ),
    );
  }
}
