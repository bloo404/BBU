package com.example.pawtect.ui.screen

import PetViewModel
import android.annotation.SuppressLint
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FabPosition
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import com.example.pawtect.R
import com.example.pawtect.data.PetData
import com.example.pawtect.data.PetEntity
import com.example.pawtect.data.PetRepository
import com.example.pawtect.ui.theme.DeepBlue
import com.example.pawtect.ui.theme.LightBlue
import com.example.pawtect.ui.theme.LighterBlue

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@Composable
fun HomeScreen(navController: NavController, viewModel: PetViewModel)  {
    val petList by viewModel.readAllData.observeAsState(emptyList())

    DisposableEffect(Unit) {
        onDispose {  }
    }

    Scaffold(
        bottomBar = {
            BottomAppBar(
                contentPadding = PaddingValues(16.dp),
                containerColor = Color.Transparent
            ) {}
        },
        floatingActionButtonPosition = FabPosition.End,
        floatingActionButton = {
            FloatingActionButton(onClick = {
                navController.navigate("add")
            }, containerColor = LighterBlue, shape = CircleShape) {
                Icon(
                    imageVector = Icons.Filled.Add,
                    contentDescription = "Add",
                    tint = Color.White,
                )
            }
        }) {
        Box(
            modifier = Modifier
                .background(DeepBlue)
                .padding(24.dp)
                .fillMaxSize()
        ) {
            LazyColumn() {
                item {
                    Header()
                    Spacer(modifier = Modifier.height(24.dp))
                    SearchField()
                    Spacer(modifier = Modifier.height(24.dp))
                    Text(
                        "New pets",
                        style = TextStyle(color = Color.White, fontWeight = FontWeight.Bold)
                    )
                    Spacer(Modifier.height(12.dp))
                }
                items(petList) { petEntity ->
                    PetListItem(item = petEntity, onCardClick = { pet ->
                        navController.navigate("details/${pet.id}")
                    })
                }
            }
        }
    }
}

@Composable
fun Header(name: String = "pet adopter") {
    Row(
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(verticalArrangement = Arrangement.Center) {
            Text(
                text = "Welcome, $name",
                style = MaterialTheme.typography.headlineMedium,
                fontWeight = FontWeight.Bold,
                fontSize = 30.sp,
                color = Color.White
            )
            Text(
                text = "Hoping a pet is finding an owner and that will be you",
                style = MaterialTheme.typography.bodyMedium,
                color = Color.White
            )
        }
        Icon(
            painter = painterResource(id = R.drawable.baseline_pets_24),
            contentDescription = "  a pet icon",
            tint = Color.White,
            modifier = Modifier
                .size(45.dp)
                .rotate(45.0f)
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchField() {
    val textFieldValue = remember { mutableStateOf("") }
    TextField(
        value = textFieldValue.value,
        onValueChange = { value -> textFieldValue.value = value },
        textStyle = TextStyle(
            fontSize = 12.sp,
            color = Color.White,
        ),
        maxLines = 1,
        placeholder = {
            Text(
                text = "Write a pet name",
                color = Color.White,

                )
        },
        leadingIcon = {
            Icon(
                painter = painterResource(id = R.drawable.baseline_search_24),
                contentDescription = "Search icon button",
                tint = Color.White
            )
        },
        colors = TextFieldDefaults.textFieldColors(
            focusedIndicatorColor = Color.Transparent,
            disabledIndicatorColor = Color.Transparent,
            errorIndicatorColor = Color.Transparent,
            unfocusedIndicatorColor = Color.Transparent,
        ),
        modifier = Modifier.fillMaxWidth(),
    )
}

@Composable
fun PetListItem(item:PetEntity, onCardClick: (PetEntity) -> Unit){
    Card(
        modifier = Modifier
            .padding(bottom = 16.dp)
            .clip(RoundedCornerShape(size = 8.dp))
            .background(LightBlue, RoundedCornerShape(8.dp))
            .clickable(onClick = { onCardClick(item) }, enabled = true)
            .padding(12.dp),
        elevation = CardDefaults.cardElevation(0.dp),
        shape = RoundedCornerShape(8.dp),
    ) {
        Column(Modifier.padding(8.dp)) {
            Box(
                Modifier
                    .fillMaxWidth()
                    .height(200.dp)
                    .clip(shape = RoundedCornerShape(6.dp))
                    .background(color = Color.Gray),
                Alignment.Center
            ) {
                Image(
                    painter = painterResource(id = item.imagePath),
                    contentDescription = null,
                    contentScale = ContentScale.Crop,
                    modifier = Modifier.fillMaxSize()
                )
            }
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                item.name,
                style = TextStyle(
                    color =  Color.White,
                    fontWeight = FontWeight.Bold,
                    fontSize = 22.sp
                )
            )
            PetDetails(age = item.age, weight = item.weight, species = item.species)
        }
    }
}

@Composable
fun PetDetails(age: Int, weight:Double, species:String){
    Row(horizontalArrangement = Arrangement.SpaceBetween){
        Column(
            Modifier
                .weight(1F)
                .align(Alignment.CenterVertically)
        ){
            val year = if (age > 1) "Years" else "Year"
            Text("Age", style = TextStyle(
                color = Color.White,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold
            ),
                textAlign = TextAlign.Center
                )
            Text("$age $year", textAlign = TextAlign.Center, color =  Color.White)
        }
        Column(
            Modifier
                .weight(1F)
                .align(Alignment.CenterVertically)
        ){
            val kg = if (weight > 1) "kgs" else "kg"
            Text("Weight", style = TextStyle(
                color = Color.White,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold
            ),
                textAlign = TextAlign.Center
            )
            Text("$weight $kg", textAlign = TextAlign.Center, color = Color.White)
        }
        Column(
            Modifier
                .weight(1F)
                .align(Alignment.CenterVertically)
        ){
            Text("Species", style = TextStyle(
                color = Color.White,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold
            ),
                textAlign = TextAlign.Center
            )
            Text("$species", textAlign = TextAlign.Right, color =  Color.White)
        }
    }
}