import 'package:flutter/material.dart';
import 'package:pawtect_flutter/pet_model.dart';
import 'package:pawtect_flutter/pet_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Color(0xFF5d9dc4),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF072233),
          ),
          padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              const SizedBox(height: 24.0),
              SearchField(),
              const SizedBox(height: 24.0),
              const Text(
                "New pets",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12.0),
              Expanded(
                child: FutureBuilder<List<Pet>>(
                  future: PetRepository.getAllPets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No pets available.');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length, // to look into it further
                        itemBuilder: (context, index) {
                          return PetListItem(item: snapshot.data![index], onCardClick: (pet) {
                          });
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, pet adopter",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
            const Text(
              "Hoping a pet is finding an owner and that will be you",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Transform.rotate(
          angle: 45.0,
          child: const Icon(
            Icons.pets,
            size: 45.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 12.0, color: Colors.white),
      decoration: InputDecoration(
        hintText: "Write a pet name",
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}

class PetListItem extends StatelessWidget {
  final Pet item;
  final void Function(Pet) onCardClick;

  const PetListItem({Key? key, required this.item, required this.onCardClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.black12,
      elevation: 0.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          onCardClick(item);
          Navigator.pushNamed(context, '/details', arguments: {'petId': item.id});
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              PetDetails(age: item.age, weight: item.weight, species: item.species),
            ],
          ),
        ),
      ),
    );
  }
}


class PetDetails extends StatelessWidget {
  final int age;
  final double weight;
  final String species;

  const PetDetails({Key? key, required this.age, required this.weight, required this.species}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _DetailColumn(label: "Age", value: "$age ${age > 1 ? 'Years' : 'Year'}"),
        _DetailColumn(label: "Weight", value: "$weight ${weight > 1 ? 'kgs' : 'kg'}"),
        _DetailColumn(label: "Species", value: species),
      ],
    );
  }
}

class _DetailColumn extends StatelessWidget {
  final String label;
  final String value;

  const _DetailColumn({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
    value,
    style
        : const TextStyle(
      color: Colors.white,
    ),
    ),
      ],
    );
  }
}
