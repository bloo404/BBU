package com.example.pawtect.data

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update

@Dao
interface PetDAO {
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    fun addPet(pet: PetEntity)

    @Update(onConflict = OnConflictStrategy.IGNORE)
    fun updatePet(pet:PetEntity): Int

    @Delete
    fun deletePet(pet: PetEntity): Int

    @Query("SELECT * FROM pet_table ORDER BY id ASC")
    fun readAllData(): LiveData<List<PetEntity>>

    @Query("SELECT * FROM pet_table WHERE pet_table.id = :petId")
    fun getPetById(petId: Int): LiveData<PetEntity>
}