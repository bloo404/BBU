from Services.RideService import RideService
from Services.TaxiService import TaxiService
from Domain.Ride import Ride
from Domain.Taxi import Taxi
from Repository.RideRepository import RideRepository
from Repository.TaxiRepository import TaxiRepository

def start():
    while True:
        taxiRepo = TaxiRepository()
        taxiServ = TaxiService()
        rideRepo = RideRepository()
        rideServ = RideService(taxiRepo,rideRepo)
        print("Welcome to Simulator")
        print("Please introduce a number from 1 to 10 to generate the taxis.")
        howMany = int(input())
        taxiServ.generate(howMany)
        taxiRepo.list()
        print("Now please add a ride:")
        x = int(input("Starting X point: "))
        y = int(input("Starting Y point: "))
        x2 = int(input("Ending X point: "))
        y2 = int(input("Ending Y point: "))
        taxiRepo.list()
        print("Now please simulate a ride:")
        number = int(input("Number of simulation of rides:"))
        rideServ.generateRide(number)
        taxiRepo.list()

start()




