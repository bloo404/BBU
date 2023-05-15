from django.db.models import Avg
from django.shortcuts import render
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import generics, status
from django.shortcuts import get_object_or_404
from django.http import HttpResponse
from rest_framework.response import Response
from .models import BotanicalGarden, Plant, Worker, Watching
from .serializers import BotanicalGardenSerializer, PlantSerializer, WorkerSerializer, OnePlantSerializer, OneWorkerSerializer, OneBotanicalGardenSerializer, WatchingSerializer, WorkerWatchingPlantSerializer, PlantWatchingWorkerSerializer

class BotanicalGardenList(generics.ListCreateAPIView):
    serializer_class = BotanicalGardenSerializer

    def get_queryset(self):
        queryset = BotanicalGarden.objects.all()
        return queryset #!!!

class BotanicalGardenDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = OneBotanicalGardenSerializer
    queryset = BotanicalGarden.objects.all()

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

class PlantList(generics.ListCreateAPIView):
    queryset = Plant.objects.all()
    serializer_class = PlantSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = {'plantHydrationLevel':["gt","lt"]}

    # http://127.0.0.1:8000/api/plant/?plantHydrationLevel__gt=0

class WorkerWatchingCreateView(generics.CreateAPIView):
    serializer_class = WorkerWatchingPlantSerializer
    queryset = Watching.objects.all()

    def get(self, request, *args, **kwargs):
        workers = Worker.objects.all()
        serializer = WorkerSerializer(workers, many=True)
        return Response(serializer.data)

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data, many=True)
        serializer.is_valid(raise_exception=True)

        data_set = request.data 

        plant_id = kwargs['plant_id']
        for elem in data_set:
           # print(elem)
            worker = elem['worker']
           # print(worker)
            worker_id = worker
            watchingReward = elem['watchingReward']
            watchingTime = elem['watchingTime']

            watching = Watching.objects.create(
                plant_id=plant_id, worker_id=worker_id, watchingReward=watchingReward, watchingTime=watchingTime)

        return Response({
            'Worker': worker,
            'Watching': watching.id
        })



class PlantWatchingCreateView(generics.CreateAPIView):
    serializer_class = PlantWatchingWorkerSerializer
    queryset = Watching.objects.all()

    def get(self, request, *args, **kwargs):
        plants = Plant.objects.all()
        serializer = PlantSerializer(plants, many=True)
        return Response(serializer.data)

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data, many=True)
        serializer.is_valid(raise_exception=True)

        data_set = request.data

        worker_id = kwargs['worker_id']
        for elem in data_set:
            #print(elem)
            plant = elem['plant']
            #print(plant)
            plant_id = plant
            watchingReward = elem['watchingReward']
            watchingTime = elem['watchingTime']

            watching = Watching.objects.create(
                plant_id=plant_id, worker_id=worker_id, watchingReward=watchingReward, watchingTime=watchingTime)

        return Response({
            'Plant': plant,
            'Watching': watching.id
        })