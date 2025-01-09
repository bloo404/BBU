import 'package:flutter/material.dart';
import 'package:pawtect_flutter/pet_model.dart';
import 'package:pawtect_flutter/pet_repository.dart';

class DetailsScreen extends StatelessWidget {
  final Function() onNavigateBack;
  final int petIndex;

  DetailsScreen({required this.onNavigateBack, required this.petIndex});

  @override
  Widget build(BuildContext context) {
    var petData = PetRepository.getPetById(petIndex);

    if (petData != null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onNavigateBack,
          ),
          title: Text('Pets'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
              },
            ),
          ],
          backgroundColor: Color(0xFF072233),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  PetRepository.deletePet(petData.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pet deleted successfully!'),
                    ),
                  );
                  onNavigateBack();
                },
                style: ElevatedButton.styleFrom(primary: Color(0xFF5d9dc4)),
                child: Text(
                  'Adopt me',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/update', arguments: {'petId': petData.id});
                },
                backgroundColor: Color(0xFF5d9dc4),
                child: Icon(Icons.create),
              ),
              FloatingActionButton(
                onPressed: () {
                  // Additional action
                },
                backgroundColor: Color(0xFF5d9dc4),
                child: Icon(Icons.menu),
              ),
              FloatingActionButton(
                onPressed: () {
                  // Additional action
                },
                backgroundColor: Color(0xFF5d9dc4),
                child: Icon(Icons.phone),
              ),
            ],
          ),
        ),
        body: Container(
          color: Color(0xFF072233),
          padding: EdgeInsets.all(16.0),
          child: Body(petData: petData),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pet not found!'),
        ),
      );
      onNavigateBack();
      return Container();
    }
  }
}

class Body extends StatelessWidget {
  final Pet petData;

  Body({required this.petData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 280.0,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Image.asset(
            'assets/images/${petData.imagePath}',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          petData.name,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailsBox(title: 'Species', info: '${petData.species}'),
            SizedBox(width: 6.0),
            DetailsBox(title: 'Age', info: '${petData.age}'),
            SizedBox(width: 6.0),
            DetailsBox(title: 'Weight', info: '${petData.weight}'),
            SizedBox(width: 6.0),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Summary',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        SizedBox(height: 12.0),
        Text(
          'Lovely pet here!',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ],
    );
  }
}

class DetailsBox extends StatelessWidget {
  final String title;
  final String info;

  DetailsBox({required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Text(
            info,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
