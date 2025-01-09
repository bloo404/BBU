package com.example.pawtect.data

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "pet_table")
data class PetEntity (
    @PrimaryKey(autoGenerate = true)
    val id: Int,
    val name: String,
    val age: Int,
    val species: String,
    val weight: Double,
    val imagePath: Int
)