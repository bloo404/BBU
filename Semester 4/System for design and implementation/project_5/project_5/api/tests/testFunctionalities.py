from unittest import TestCase
from rest_framework.test import APIRequestFactory, APITestCase
from api.models import BotanicalGarden, Plant, Worker, Watching


class testAllFilters(APITestCase):

    @classmethod
    def setUpTestData(cls):
        # Botanical Garden
        BotanicalGarden.objects.create(bgName = "Gradina1", bgCapacity = 1, bgPlants = 1, bgYear = "1950-03-03", bgLocation = "Cluj")
        BotanicalGarden.objects.create(bgName="Gradina2", bgCapacity=2, bgPlants=2, bgYear="1960-03-03", bgLocation="Timisoara")
        BotanicalGarden.objects.create(bgName="Gradina3", bgCapacity=3, bgPlants=3, bgYear="1970-03-03", bgLocation="Sibiu")
        BotanicalGarden.objects.create(bgName="Gradina4", bgCapacity=4, bgPlants=4, bgYear="1980-03-03", bgLocation="Bucuresti")
        BotanicalGarden.objects.create(bgName="Gradina5", bgCapacity=5, bgPlants=5, bgYear="1990-03-03", bgLocation="Iasi")

        # Plants
        Plant.objects.create(plantParent_id=1, plantCommonName="Plant1", plantLatinName="LatinName1", plantLength=1, plantLightLevel=1,
                             plantTemperatureLevel=1, plantSoilType="Type1", plantHydrationLevel=1, plantAge=1)
        Plant.objects.create(plantParent_id=2, plantCommonName="Plant2", plantLatinName="LatinName2", plantLength=2, plantLightLevel=2,
                             plantTemperatureLevel=2, plantSoilType="Type2", plantHydrationLevel=2, plantAge=2)
        Plant.objects.create(plantParent_id=3, plantCommonName="Plant3", plantLatinName="LatinName3", plantLength=3, plantLightLevel=3,
                             plantTemperatureLevel=3, plantSoilType="Type3", plantHydrationLevel=3, plantAge=3)
        Plant.objects.create(plantParent_id=4, plantCommonName="Plant4", plantLatinName="LatinName4", plantLength=4, plantLightLevel=4,
                             plantTemperatureLevel=4, plantSoilType="Type4", plantHydrationLevel=4, plantAge=4)
        Plant.objects.create(plantParent_id=5, plantCommonName="Plant5", plantLatinName="LatinName5", plantLength=5, plantLightLevel=5,
                             plantTemperatureLevel=5, plantSoilType="Type5", plantHydrationLevel=5, plantAge=5)

        # Worker
        Worker.objects.create(workerParent_id=1,workerFirstName="Worker1",workerLastName="Worker1",workerBirthDate="2003-03-03",workerStartDate="2023-03-03",workerJob="Job1")
        Worker.objects.create(workerParent_id=2,workerFirstName="Worker2",workerLastName="Worker2",workerBirthDate="2003-03-03",workerStartDate="2023-03-03",workerJob="Job2")
        Worker.objects.create(workerParent_id=3,workerFirstName="Worker3",workerLastName="Worker3",workerBirthDate="2003-03-03",workerStartDate="2023-03-03",workerJob="Job3")
        Worker.objects.create(workerParent_id=4,workerFirstName="Worker4",workerLastName="Worker4",workerBirthDate="2003-03-03",workerStartDate="2023-03-03",workerJob="Job4")
        Worker.objects.create(workerParent_id=5,workerFirstName="Worker5",workerLastName="Worker5",workerBirthDate="2003-03-03",workerStartDate="2023-03-03",workerJob="Job5")

        # Watching
        Watching.objects.create(worker_id=1,plant_id=1,watchingTime="2023-03-03 12:34:16",watchingReward=1)
        Watching.objects.create(worker_id=2,plant_id=2,watchingTime="2023-03-03 12:34:16",watchingReward=2)
        Watching.objects.create(worker_id=3,plant_id=3,watchingTime="2023-03-03 12:34:16",watchingReward=3)
        Watching.objects.create(worker_id=4,plant_id=4,watchingTime="2023-03-03 12:34:16",watchingReward=4)
        Watching.objects.create(worker_id=5,plant_id=5,watchingTime="2023-03-03 12:34:16",watchingReward=5)

    def test_url_exists(self):
        response = self.client.get("/api/botanicalgarden/")
        self.assertEqual(response.status_code, 200)

        response = self.client.get("/api/plant/")
        self.assertEqual(response.status_code, 200)

        response = self.client.get("/api/worker/")
        self.assertEqual(response.status_code, 200)

        response = self.client.get("/api/watching/")
        self.assertEqual(response.status_code, 200)

    def test_count_correctly_returned(self):
        response = self.client.get("/api/botanicalgarden/")
        self.assertEqual(len(response.data), 5)

        response = self.client.get("/api/plant/")
        self.assertEqual(len(response.data), 5)

        response = self.client.get("/api/worker/")
        self.assertEqual(len(response.data), 5)

        response = self.client.get("/api/watching/")
        self.assertEqual(len(response.data), 5)

    def test_filter_correctly_returned(self):
        response = self.client.get("/api/botanicalgarden/garden-average-age/")
        self.assertEqual(len(response.data), 5)

        response = self.client.get("/api/plant/?plantHydrationLevel__gt=0")
        self.assertEqual(len(response.data), 5)
