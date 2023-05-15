from rest_framework import serializers
from .models import BotanicalGarden, Plant, Worker, Watching


class BotanicalGardenSerializer(serializers.ModelSerializer):
    avg_age = serializers.FloatField(read_only=True)
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
    plants = PlantSerializer(many=True)

    class Meta:
        model = BotanicalGarden
        fields = ('bgName', 'bgCapacity','bgPlants','bgYear','bgLocation','plants')
        expandable_fields = {"plant_set": (PlantSerializer, {"source": "plant_set"})}
        #fields = ('__all__')


class WorkerSerializer(serializers.ModelSerializer):
    avg_hydration = serializers.FloatField(read_only=True)

    class Meta:
        model = Worker
        fields = ('__all__')


class OneWorkerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Worker
        depth = 1
        fields = ('__all__')


class WatchingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Watching
        fields = ('__all__')
