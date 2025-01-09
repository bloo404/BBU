import android.annotation.SuppressLint
import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.KeyboardArrowLeft
import androidx.compose.material.icons.filled.Send
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalSoftwareKeyboardController
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import com.example.pawtect.ui.theme.DeepBlue
import com.example.pawtect.ui.theme.LighterBlue

@SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun UpdateScreen(navController: NavController, petIndex: Int, petViewModel: PetViewModel = viewModel()) {
    val context = LocalContext.current
    val pet by petViewModel.getPetById(petIndex).observeAsState()

    var petName by remember { mutableStateOf(pet?.name.orEmpty()) }
    var petAge by remember { mutableStateOf(pet?.age ?: 0) }
    var petWeight by remember { mutableStateOf(pet?.weight ?: 0.0) }
    var petSpecies by remember { mutableStateOf(pet?.species.orEmpty()) }

    val keyboardController = LocalSoftwareKeyboardController.current

    Scaffold(
        topBar = {
            TopAppBar(
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(
                            imageVector = Icons.Filled.KeyboardArrowLeft,
                            contentDescription = null,
                            tint = Color.White
                        )
                    }
                },
                modifier = Modifier.height(68.dp),
                title = {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = "Update Pet",
                            textAlign = TextAlign.Center,
                            modifier = Modifier.weight(1f)
                        )
                        IconButton(
                            onClick = {
                                // Do something on favorite icon click
                            }
                        ) {
                            Icon(
                                imageVector = Icons.Filled.Favorite,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = DeepBlue
                )
            )
        },

        floatingActionButton = {
            FloatingActionButton(
                shape = CircleShape,
                containerColor = LighterBlue,
                onClick = {
                    if (validateInput(petName, petAge, petWeight, petSpecies)) {
                        val updatedPet = pet?.copy(
                            name = petName,
                            age = petAge,
                            weight = petWeight,
                            species = petSpecies
                        )

                        if (updatedPet != null) {
                            petViewModel.updatePet(updatedPet)
                            Toast.makeText(context, "Pet updated successfully!", Toast.LENGTH_SHORT)
                                .show()
                            navController.popBackStack()
                        }
                    } else {
                        Toast.makeText(
                            context,
                            "Please fill in all required fields",
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                },
                modifier = Modifier
                    .padding(16.dp)
                    .clip(MaterialTheme.shapes.small)
            ) {
                Icon(imageVector = Icons.Filled.Send, contentDescription = "Send")
            }
        },
        floatingActionButtonPosition = FabPosition.End,
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(DeepBlue)
                .padding(16.dp),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(68.dp))

            OutlinedTextField(
                value = petName,
                onValueChange = { petName = it },
                label = { Text("Name") },
                textStyle = TextStyle(color = Color.White),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
            )

            OutlinedTextField(
                value = petAge.toString(),
                onValueChange = { petAge = it.toIntOrNull() ?: 0 },
                label = { Text("Age") },
                textStyle = TextStyle(color = Color.White),
                keyboardOptions = KeyboardOptions.Default.copy(
                    imeAction = androidx.compose.ui.text.input.ImeAction.Done
                ),
                keyboardActions = KeyboardActions(
                    onDone = {
                        keyboardController?.hide()
                    }
                ),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
            )

            OutlinedTextField(
                value = petWeight.toString(),
                onValueChange = { petWeight = it.toDoubleOrNull() ?: 0.0 },
                label = { Text("Weight") },
                textStyle = TextStyle(color = Color.White),
                keyboardOptions = KeyboardOptions.Default.copy(
                    imeAction = androidx.compose.ui.text.input.ImeAction.Done
                ),
                keyboardActions = KeyboardActions(
                    onDone = {
                        keyboardController?.hide()
                    }
                ),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
            )

            OutlinedTextField(
                value = petSpecies,
                onValueChange = { petSpecies = it },
                label = { Text("Species") },
                textStyle = TextStyle(color = Color.White),
                keyboardOptions = KeyboardOptions.Default.copy(
                    imeAction = androidx.compose.ui.text.input.ImeAction.Done
                ),
                keyboardActions = KeyboardActions(
                    onDone = {
                        keyboardController?.hide()
                    }
                ),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
            )
        }
    }
}
