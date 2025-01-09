import 'package:flutter/material.dart';
import 'package:practical_exam/models/entity.dart';

class ViewEntity extends StatelessWidget {
  final Entity entity;

  const ViewEntity({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Entity"),
      ),
      body: ListView(
        children: [
          _buildInfoItem("Name", entity.name),
          _buildInfoItem("Team", entity.team),
          _buildInfoItem("Details", entity.details),
          _buildInfoItem("Status", entity.status),
          _buildInfoItem("Participants", entity.participants.toString()),
          _buildInfoItem("Type", entity.type),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
