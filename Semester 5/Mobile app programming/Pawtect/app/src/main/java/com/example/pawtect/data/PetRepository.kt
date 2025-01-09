package com.example.pawtect.data

import android.util.Log
import androidx.lifecycle.LiveData

class PetRepository(
    private val petDao: PetDAO,
) {
    val readAllData: LiveData<List<PetEntity>> = petDao.readAllData()

    suspend fun addPet(pet: PetEntity) {
        try {
            petDao.addPet(pet)
        } catch (e: Exception) {
        }
    }

    suspend fun updatePet(updatedPet: PetEntity) {
        try {
            petDao.updatePet(updatedPet)
        } catch (e: Exception) {
        }
    }

    suspend fun deletePet(pet: PetEntity) {
        try {
            petDao.deletePet(pet)
        } catch (e: Exception) {
        }
    }

    fun getPetById(petId: Int): LiveData<PetEntity> {
        return petDao.getPetById(petId)
    }

    suspend fun getNextPetId(): Int {
        return readAllData.value?.lastOrNull()?.id?.plus(1) ?: 1
    }
}
