from django.contrib import admin
from .models import BotanicalGarden, Plant, Worker, Watching

admin.site.register(BotanicalGarden)
admin.site.register(Plant)
admin.site.register(Worker)
admin.site.register(Watching)