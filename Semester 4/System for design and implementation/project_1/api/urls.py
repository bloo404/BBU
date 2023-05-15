from django.urls import path
from .views import BotanicalGardenList, BotanicalGardenDetail

urlpatterns = [
    path('botanicalgarden/',BotanicalGardenList.as_view()),
    path('botanicalgarden/<int:pk>/', BotanicalGardenDetail.as_view())
]