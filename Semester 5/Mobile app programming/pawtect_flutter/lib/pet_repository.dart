import 'package:pawtect_flutter/pet_model.dart';

class PetRepository {
  static List<Pet> pets = [
    Pet(id: 0, name: "Pufilici", age: 2, species: "cat", weight: 5.0, imagePath: "assets/pet1.jpg"),
    Pet(id: 1, name: "Zorzonel", age: 0, species: "dog", weight:1.5, imagePath:"assets/pet2.png"),
    Pet(id: 2, name: "Placuta", age: 5, species: "turtle", weight:10.0, imagePath:"assets/pet3.jpg"),
    Pet(id: 3, name: "360 colors", age: 1, species: "chameleon", weight:0.5, imagePath:"assets/pet4.png"),
  ];

  static Future<List<Pet>> getAllPets() {
    return Future.value(pets);
  }

  static Pet? getPetById(int petId) {
    try {
      return pets.firstWhere((pet) => pet.id == petId);
    } catch (e) {
      return null;
    }
  }

  static void addPet(Pet pet) {
    pets.add(pet);
  }

  static void updatePet(Pet updatedPet) {
    final index = pets.indexWhere((pet) => pet.id == updatedPet.id);
    if (index != -1) {
      pets[index] = updatedPet;
    }
  }

  static void deletePet(int petId) {
    pets.removeWhere((pet) => pet.id == petId);
  }

  static int getNextPetId() {
    return pets.isNotEmpty ? pets.last.id + 1 : 0;
  }
}
