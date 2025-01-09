import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.viewModelScope
import com.example.pawtect.data.PetDatabase
import com.example.pawtect.data.PetEntity
import com.example.pawtect.data.PetRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class PetViewModel(application: Application) : AndroidViewModel(application) {

    val readAllData: LiveData<List<PetEntity>>
    private val repository: PetRepository

    init {
        val petDao = PetDatabase.getDatabase(application).petDao()
        repository = PetRepository(petDao)
        readAllData = repository.readAllData
    }

    fun addPet(pet: PetEntity) {
        viewModelScope.launch(Dispatchers.IO) {
            repository.addPet(pet)
        }
    }

    fun getPetById(petId: Int): LiveData<PetEntity> {
        return repository.getPetById(petId)
    }

    fun deletePet(pet: PetEntity?) {
        viewModelScope.launch(Dispatchers.IO) {
            if (pet != null) {
                repository.deletePet(pet)
            }
        }
    }

    fun updatePet(pet: PetEntity) {
        viewModelScope.launch(Dispatchers.IO) {
            repository.updatePet(pet)
        }
    }
}