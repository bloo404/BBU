from Domain.Ride import Ride
from Domain.Taxi import Taxi
from Repository.TaxiRepository import TaxiRepository

from random import randint

class RideService:
    def __init__(self, taxirepo,riderepo):
        self.__taxiRepo = taxirepo
        self.__rideRepo = riderepo

    def createRide(self,xStart,yStart,xEnd,yEnd):
        newRide = Ride(xStart,yStart,xEnd,yEnd)
        self.__rideRepo.addRide(newRide)

    def generateRide(self,howMany):
        for iterator in range(howMany + 1):
            self.__rideRepo.get_rideRepo().addRide(Ride(iterator, randint(0, 100), randint(0, 100)))

    def manhattanDistance(self,x,y,x2,y2):
        xres = x-x2
        yres = y-y2
        if xres<0:
            xres=xres*(-1)
        if yres<0:
            yres=yres*(-1)
        return xres + yres

    def assignTaxi(self,ride):
        minimumRide = 100
        id = ""
        for taxi in self.__taxiRepo:
            if self.manhattanDistance(taxi.get_x(),taxi.get_y(),ride.get_xstart(),ride.get_ystart())<minimumRide:
                minimumRide = self.manhattanDistance(taxi.get_x(),taxi.get_y(),ride.get_xstart(),ride.get_ystart())<minimumRide
                id = taxi.get_ID()
        for taxi in self.__taxiRepo:
            if taxi.get_ID()==id:
                taxi.set_x(ride.get_xend())
                taxi.set_y(ride.get_yend())
                taxi.set_totalFare(taxi.get_totalFare()+minimumRide)



