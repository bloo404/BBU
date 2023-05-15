from django.db import models

class BotanicalGarden(models.Model):
    bgName = models.CharField(max_length=100, unique = True)
    bgCapacity = models.PositiveIntegerField()
    bgPlants = models.PositiveIntegerField()
    bgYear = models.DateField()
    bgLocation = models.CharField(max_length=200, unique = True)

    def __str__(self):
        return f"{self.bgName} {self.bgYear}"

class Plant(models.Model):
    plantParent = models.ForeignKey(BotanicalGarden,related_name='plants',on_delete=models.CASCADE, null=True) # to change into botanicalgarden_id and migrate
    plantCommonName = models.CharField(max_length = 100, unique = True)
    plantLatinName = models.CharField(max_length = 200, unique = True)
    plantLength = models.PositiveIntegerField()
    plantLightLevel = models.PositiveIntegerField()
    plantTemperatureLevel = models.PositiveIntegerField()
    plantSoilType = models.CharField(max_length = 100)
    plantHydrationLevel = models.PositiveIntegerField()
    plantAge = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.plantLatinName} {self.plantCommonName}"

class Worker(models.Model):
    workerParent = models.ForeignKey(BotanicalGarden,related_name='workers',on_delete=models.CASCADE, null=True) # to change into botanicalgarden_id and migrate
    workerFirstName = models.CharField(max_length = 100)
    workerLastName = models.CharField(max_length = 100)
    workerBirthDate = models.DateField()
    workerStartDate = models.DateField()
    workerJob = models.CharField(max_length = 100)

    def __str__(self):
        return f"{self.workerLastName} {self.workerFirstName} {self.workerJob}"

class Watching(models.Model):
    worker = models.ForeignKey(Worker, on_delete=models.CASCADE,
                                    null=True)  # to change into botanicalgarden_id and migrate
    plant = models.ForeignKey(Plant, on_delete=models.CASCADE,
                                    null=True)  # to change into botanicalgarden_id and migrate
    watchingTime = models.DateTimeField()
    watchingReward = models.IntegerField()

    def __str__(self):
        return f"{self.worker_id} {self.plant_id}"