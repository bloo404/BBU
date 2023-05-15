from rest_framework import serializers
from .models import BotanicalGarden, Plant, Worker

class BotanicalGardenSerializer(serializers.ModelSerializer):
    class Meta:
        model = BotanicalGarden
        fields = ('__all__')

class PlantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        fields = ('__all__')

class OnePlantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        depth = 1
        fields = ('__all__')

class OneBotanicalGardenSerializer(serializers.ModelSerializer):
    plants = PlantSerializer(source = 'plant_set', many= True)
    class Meta:
        Model = BotanicalGarden
        fields = ('plantCommonName', 'plantHydrationLevel', 'plants')
        expandable_fields = {"plant_set": (PlantSerializer, {"source": "plant_set"})}

class WorkerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Worker
        fields = ('__all__')

class OneWorkerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Worker
        depth = 1
        fields = ('__all__')

#class BotanicalGardenSerializerWithKids(serializers.ModelSerializer):
    #plants = PlantSerializer(many = True)
    #workers = WorkerSerializer(many = True)
#    class Meta:
#        model = BotanicalGarden
#        depth = 1
#        fields = ('__all__')

