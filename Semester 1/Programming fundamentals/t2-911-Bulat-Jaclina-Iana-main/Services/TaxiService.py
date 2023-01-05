from Domain.Taxi import Taxi
from Services.RideService import RideService
from random import randint

class TaxiService:
    def __int__(self,taxiRepo,rideService):
        self._taxiRepo = taxiRepo
        self._rideService = rideService

    def generate(self,howMany):
        for iterator in range(howMany+1):
            self._taxiRepo.get_taxiRepo().addTaxi(Taxi(iterator,randint(0,100),randint(0,100)))



