from django.db import models

class BotanicalGarden(models.Model):
    bgName = models.CharField(max_length=100, unique = True)
    bgCapacity = models.PositiveIntegerField()
    bgPlants = models.PositiveIntegerField()
    bgYear = models.DateField()
    bgLocation = models.CharField(max_length=200, unique = True)

    def __str__(self):
        return self.bgName + " | " + self.bgYear