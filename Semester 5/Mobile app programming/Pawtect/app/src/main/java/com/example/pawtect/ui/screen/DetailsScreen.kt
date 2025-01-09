package com.example.pawtect.ui.screen

import PetViewModel
import android.annotation.SuppressLint
import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Create
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Phone
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.example.pawtect.data.PetEntity
import com.example.pawtect.ui.theme.DeepBlue
import com.example.pawtect.ui.theme.LightBlue
import com.example.pawtect.ui.theme.LighterBlue

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DetailsScreen(navController: NavController, petIndex: Int, viewModel: PetViewModel) {
    val context = LocalContext.current
    val petDataState by rememberUpdatedState(newValue = viewModel.getPetById(petIndex))
    val petData = petDataState.value

    Log.d("DetailsScreen", "Pet data: $petData")

    if (petData != null) {
        Log.d("DetailsScreen", "Pet data: $petData")

        Scaffold(
            topBar = {
                TopAppBar(
                    navigationIcon = {
                        IconButton(onClick = { navController.popBackStack() }) {
                            Icon(
                                imageVector = Icons.Filled.ArrowBack,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                    },
                    modifier = Modifier.fillMaxWidth(),
                    title = {
                        Text(
                            text = "Pets",
                            textAlign = TextAlign.Center,
                            modifier = Modifier.fillMaxWidth(),
                            color = Color.White
                        )
                    },
                    actions = {
                        IconButton(onClick = { }) {
                            Icon(
                                imageVector = Icons.Filled.Favorite,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                    },
                    colors = TopAppBarDefaults.topAppBarColors(
                        containerColor = DeepBlue
                    )
                )
            },
            bottomBar = {
                Row(Modifier.padding(16.dp), horizontalArrangement = Arrangement.Center) {
                    Button(
                        onClick = {
                            viewModel.deletePet(petData)
                            Toast.makeText(context, "Pet deleted successfully!", Toast.LENGTH_SHORT)
                                .show()
                            navController.popBackStack()
                        },
                        Modifier
                            .height(53.dp),
                        colors = ButtonDefaults.buttonColors(LighterBlue),
                        elevation = ButtonDefaults.buttonElevation(0.dp)
                    ) {
                        Text(
                            "Adopt me",
                            style = MaterialTheme.typography.headlineSmall,
                            color = Color.White
                        )
                    }
                    FloatingActionButton(
                        onClick = {
                            navController.navigate("update/${petData.id}") {
                                launchSingleTop = true
                            }
                        },
                        containerColor = LighterBlue,
                        shape = CircleShape
                    ) {
                        Icon(
                            imageVector = Icons.Filled.Create,
                            contentDescription = "Edit",
                            tint = Color.White
                        )
                    }
                    FloatingActionButton(
                        onClick = { },
                        containerColor = LighterBlue,
                        shape = CircleShape
                    ) {
                        Icon(
                            imageVector = Icons.Filled.Menu,
                            contentDescription = "Raport",
                            tint = Color.White
                        )
                    }
                    FloatingActionButton(
                        onClick = { },
                        containerColor = LighterBlue,
                        shape = CircleShape
                    ) {
                        Icon(
                            imageVector = Icons.Filled.Phone,
                            contentDescription = "Vet",
                            tint = Color.White
                        )
                    }
                }
            },
            containerColor = DeepBlue
        ) {
            petData.let { pet ->
                Body(Modifier.padding(16.dp), petData = pet)
            }
        }
    } else {
        Log.e("DetailsScreen", "Pet data is null for petIndex: $petIndex")

        Toast.makeText(context, "Pet not found or invalid data!", Toast.LENGTH_SHORT).show()
        navController.popBackStack()
    }
}

@Composable
fun Body(modifier: Modifier, petData: PetEntity) {
    Column(modifier = modifier) {
        Box(
            Modifier
                .fillMaxWidth()
                .height(280.dp)
                .clip(shape = RoundedCornerShape(8.dp))
        ) {
            Image(
                painter = painterResource(id = petData.imagePath),
                contentDescription = null,
                contentScale = ContentScale.Crop,
                modifier = Modifier.fillMaxSize()
            )
        }
        Spacer(modifier = Modifier.height(12.dp))
        Text(petData.name, style = MaterialTheme.typography.bodyLarge, color = Color.White)
        Spacer(modifier = Modifier.height(12.dp))
        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            val mod = Modifier
                .clip(shape = RoundedCornerShape(size = 8.dp))
                .weight(1f)
                .background(LightBlue)
                .padding(all = 8.dp)
            DetailsBox(title = "Species", info = petData.species, mod)
            Spacer(modifier = Modifier.width(6.dp))
            DetailsBox(title = "Age", info = "${petData.age}", mod)
            Spacer(modifier = Modifier.width(6.dp))
            DetailsBox(title = "Weight", info = "${petData.weight}", mod)
            Spacer(modifier = Modifier.width(6.dp))
        }
        Spacer(modifier = Modifier.height(12.dp))
        Text("Summary", style = MaterialTheme.typography.bodyMedium, color = Color.White)
        Spacer(modifier = Modifier.height(12.dp))
        Text("Lovely pet here!", style = MaterialTheme.typography.bodyMedium, color = Color.White)
    }
}

@Composable
fun DetailsBox(title: String, info: String, modifier: Modifier = Modifier) {
    Box(modifier = modifier) {
        Column() {
            Text(
                text = title,
                Modifier.fillMaxWidth(),
                textAlign = TextAlign.Center,
                color = Color.White
            )
            Text(
                text = info,
                Modifier.fillMaxWidth(),
                textAlign = TextAlign.Center,
                color = Color.White
            )
        }
    }
}