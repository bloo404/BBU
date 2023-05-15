from django.urls import path
from .views import BotanicalGardenList, BotanicalGardenDetail, PlantList, PlantDetail, WorkerList, WorkerDetail, WatchingList, WatchingDetail, WorkersByAvgHydrationLevel, BotanicalGardensByAvgPlantAge, WorkerWatchingCreateView, PlantWatchingCreateView

urlpatterns = [
    path('botanicalgarden/',BotanicalGardenList.as_view()),
    path('botanicalgarden/<int:pk>', BotanicalGardenDetail.as_view()),
    path('plant/', PlantList.as_view()),
    path('plant/<int:pk>', PlantDetail.as_view()),
    path('worker/', WorkerList.as_view()),
    path('worker/<int:pk>', WorkerDetail.as_view()),
    path('watching/', WatchingList.as_view()),
    path('watching/<int:pk>', WatchingDetail.as_view()),
    path('watching/workers-average-hydration/',WorkersByAvgHydrationLevel.as_view()),
    path('botanicalgarden/garden-average-age/',BotanicalGardensByAvgPlantAge.as_view()),
    path('plant/<int:plant_id>/worker/', WorkerWatchingCreateView.as_view()),
    path('worker/<int:worker_id>/plant/', PlantWatchingCreateView.as_view()),
]