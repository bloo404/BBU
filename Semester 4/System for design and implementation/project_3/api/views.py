from django.db.models import Avg
from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import generics

from .models import BotanicalGarden, Plant, Worker, Watching
from .serializers import BotanicalGardenSerializer, PlantSerializer, WorkerSerializer, OnePlantSerializer, OneWorkerSerializer, OneBotanicalGardenSerializer, WatchingSerializer

class BotanicalGardenList(generics.ListCreateAPIView):
    serializer_class = BotanicalGardenSerializer

    def get_queryset(self):
        queryset = BotanicalGarden.objects.all()
        return queryset #!!!

class BotanicalGardenDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = OneBotanicalGardenSerializer
    queryset = BotanicalGarden.objects.all()

class PlantList(generics.ListCreateAPIView):
    queryset = Plant.objects.all()
    serializer_class = PlantSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {'plantHydrationLevel':["gt","lt"]}

    # http://127.0.0.1:8000/api/plant/?plantHydrationLevel__gt=0


class PlantDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = OnePlantSerializer
    queryset = Plant.objects.all()

class WorkerList(generics.ListCreateAPIView):
    serializer_class = WorkerSerializer

    def get_queryset(self):
        queryset = Worker.objects.all()
        return queryset

class WorkerDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = OneWorkerSerializer
    queryset = Worker.objects.all()

class WatchingList(generics.ListCreateAPIView):
    serializer_class = WatchingSerializer
    def get_queryset(self):
        queryset = Watching.objects.all()
        return queryset

class WatchingDetail(generics.ListCreateAPIView):
    serializer_class = WatchingSerializer
    queryset = Watching.objects.all()

class WorkersByAvgHydrationLevel(generics.ListCreateAPIView):
    serializer_class = WorkerSerializer
    def get_queryset(self):
        query = Worker.objects.\
            annotate(avg_hydration = Avg('watching__plant__plantHydrationLevel')).\
            order_by('avg_hydration')
        return query

class BotanicalGardensByAvgPlantAge(generics.ListCreateAPIView):
    serializer_class = BotanicalGardenSerializer
    def get_queryset(self):
        query = BotanicalGarden.objects.\
            annotate(avg_age = Avg('plants__plantAge')).\
            order_by('avg_age')
        return query