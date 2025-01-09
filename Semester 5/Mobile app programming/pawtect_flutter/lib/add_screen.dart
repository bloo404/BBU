import 'package:flutter/material.dart';
import 'package:pawtect_flutter/pet_model.dart';
import 'package:pawtect_flutter/pet_repository.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var petName = '';
    var petAge = '';
    var petWeight = '';
    var petSpecies = '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Add Pet'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color(0xFF072233),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (validateInput(petName, petAge, petWeight, petSpecies)) {
            final pet = Pet(
              id: PetRepository.getNextPetId(),
              name: petName,
              age: int.parse(petAge),
              weight: double.parse(petWeight),
              species: petSpecies,
              imagePath: 'assets/default_pet_image.png',
            );

            PetRepository.addPet(pet);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Pet added successfully!'),
              ),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please fill in all required fields'),
              ),
            );
          }
        },
        backgroundColor: Color(0xFF5d9dc4),
        child: Icon(Icons.send),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 68),
            TextField(
              onChanged: (value) {
                petName = value;
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              onChanged: (value) {
                petAge = value;
              },
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              onChanged: (value) {
                petWeight = value;
              },
              decoration: InputDecoration(labelText: 'Weight'),
            ),
            TextField(
              onChanged: (value) {
                petSpecies = value;
              },
              decoration: InputDecoration(labelText: 'Species'),
            ),
          ],
        ),
      ),
    );
  }
}

bool validateInput(String name, String age, String weight, String species) {
  if (int.tryParse(age) == null ||
      double.tryParse(weight) == null ||
      name.trim().isEmpty ||
      species.trim().isEmpty) {
    return false;
  }
  return true;
}
