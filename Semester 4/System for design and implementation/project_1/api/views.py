from django.shortcuts import render
from rest_framework import generics

from .models import BotanicalGarden
from .serializers import BotanicalGardenSerializer

class BotanicalGardenList(generics.ListCreateAPIView):
    serializer_class = BotanicalGardenSerializer

    def get_queryset(self):
        queryset = BotanicalGarden.objects.all()
        return queryset #!!!

class BotanicalGardenDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = BotanicalGardenSerializer
    queryset = BotanicalGarden.objects.all()