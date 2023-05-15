from django.urls import path
from .views import BotanicalGardenList, BotanicalGardenDetail, PlantList, PlantDetail, WorkerList, WorkerDetail

urlpatterns = [
    path('botanicalgarden/',BotanicalGardenList.as_view()),
    path('botanicalgarden/<int:pk>', BotanicalGardenDetail.as_view()),
    path('plant/', PlantList.as_view()),
    path('plant/<int:pk>', PlantDetail.as_view()),
    path('worker/', WorkerList.as_view()),
    path('worker/<int:pk>', WorkerDetail.as_view())
]