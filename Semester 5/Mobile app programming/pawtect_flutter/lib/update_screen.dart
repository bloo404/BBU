import 'package:flutter/material.dart';
import 'package:pawtect_flutter/pet_repository.dart';
import 'package:pawtect_flutter/pet_model.dart';

class UpdateScreen extends StatefulWidget {
  final Function() onNavigateBack;
  final int petIndex;

  UpdateScreen({required this.onNavigateBack, required this.petIndex});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late String petName;
  late int petAge;
  late double petWeight;
  late String petSpecies;

  @override
  void initState() {
    super.initState();
    var pet = PetRepository.getPetById(widget.petIndex);
    petName = pet?.name ?? '';
    petAge = pet?.age ?? 0;
    petWeight = pet?.weight ?? 0.0;
    petSpecies = pet?.species ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: widget.onNavigateBack,
        ),
        title: Text('Update Pet'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              },
          ),
        ],
        backgroundColor: Color(0xFF072233),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (validateInput(petName, petAge, petWeight, petSpecies)) {
            PetRepository.updatePet(Pet(
              id: widget.petIndex,
              name: petName,
              age: petAge,
              weight: petWeight,
              species: petSpecies,
              imagePath: '',
            ));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Pet updated successfully!'),
              ),
            );
            widget.onNavigateBack();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please fill in all required fields'),
              ),
            );
          }
        },
        backgroundColor: Color(0xFF5d9dc4),
        child: Icon(Icons.send, color: Colors.white),
      ),
      body: Container(
        color: Color(0xFF072233),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(flex: 2),
            TextField(
              controller: TextEditingController(text: petName),
              onChanged: (value) => setState(() => petName = value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: TextEditingController(text: petAge.toString()),
              onChanged: (value) => setState(() => petAge = int.tryParse(value) ?? 0),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: TextEditingController(text: petWeight.toString()),
              onChanged: (value) => setState(() => petWeight = double.tryParse(value) ?? 0.0),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Weight',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: TextEditingController(text: petSpecies),
              onChanged: (value) => setState(() => petSpecies = value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Species',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  bool validateInput(String name, int age, double weight, String species) {
    return age >= 0 && weight > 0 && name.isNotEmpty && species.isNotEmpty;
  }
}
