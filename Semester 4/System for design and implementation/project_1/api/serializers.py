from rest_framework import serializers
from .models import BotanicalGarden

class BotanicalGardenSerializer(serializers.ModelSerializer):
    class Meta:
        model = BotanicalGarden
        fields = ('__all__')