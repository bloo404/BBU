import 'package:flutter/material.dart';
import 'package:practical_exam/models/entity.dart';

class DetailsScreen extends StatelessWidget {
  final Entity entity;

  const DetailsScreen({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entity.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${entity.date}'),
            Text('Details: ${entity.details}'),
            Text('Status: ${entity.status}'),
            Text('Participants: ${entity.participants}'),
            Text('Type: ${entity.type}'),
          ],
        ),
      ),
    );
  }
}
