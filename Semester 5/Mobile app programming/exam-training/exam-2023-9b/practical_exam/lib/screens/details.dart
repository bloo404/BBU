import 'package:flutter/material.dart';
import 'package:practical_exam/models/entity.dart';

class DetailsView extends StatelessWidget {
  final Entity entity;

  const DetailsView({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${entity.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Breed: ${entity.breed}'),
            const SizedBox(height: 8),
            Text('Age: ${entity.age} years'),
            const SizedBox(height: 8),
            Text('Weight: ${entity.weight} lbs'),
            const SizedBox(height: 8),
            Text('Owner: ${entity.owner}'),
            const SizedBox(height: 8),
            Text('Location: ${entity.location}'),
            const SizedBox(height: 8),
            Text('Description: ${entity.description}'),
          ],
        ),
      ),
    );
  }
}
