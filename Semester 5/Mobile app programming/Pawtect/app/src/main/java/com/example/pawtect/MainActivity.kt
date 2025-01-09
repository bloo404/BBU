package com.example.pawtect

import AddScreen
import PetViewModel
import UpdateScreen
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.runtime.Composable
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.pawtect.ui.screen.DetailsScreen
import com.example.pawtect.ui.screen.HomeScreen
import com.example.pawtect.ui.theme.PawtectTheme

@OptIn(ExperimentalComposeUiApi::class)
class MainActivity : ComponentActivity() {
    private val petViewModel: PetViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PawtectTheme {
                MyApp(navController = rememberNavController(), )
            }
        }
    }
}

@Composable
fun MyApp(navController: NavHostController) {
    val petViewModel: PetViewModel = viewModel()
    val context = LocalContext.current

    NavHost(navController = navController, startDestination = "home") {
        composable(route = "home") {
            HomeScreen(navController = navController, viewModel = petViewModel)
        }
        composable(
            route = "details/{petIndex}",
            arguments = listOf(navArgument("petIndex") { type = NavType.IntType })
        ) {
            val petIndex = it.arguments?.getInt("petIndex") ?: 0
            DetailsScreen(navController, petIndex, viewModel = petViewModel)
        }
        composable(route = "add") {
            AddScreen(navController = navController, viewModel = petViewModel)
        }
        composable(
            route = "update/{petIndex}",
            arguments = listOf(navArgument("petIndex") { type = NavType.IntType })
        ) {
            val petIndex = it.arguments?.getInt("petIndex") ?: 0
            UpdateScreen(navController = navController, petIndex = petIndex, petViewModel = petViewModel)
        }
    }
}