from Services.RideService import RideService
class RideRepository:
    def __init__(self):
        self._rideRepo = []

    def __len__(self):
        return len(self._rideRepo)

    def get_rideRepo(self):
        return self._rideRepo

    def addRide(self,newRide):
        """
        Adds a new ride to the repository
        :param newRide: Ride object type
        """
        for ride in self._rideRepo :
            if ride.get_xstart()==newRide.get_xstart() and ride.get_xend()==newRide.get_xend() and ride.get_ystart()==newRide.get_yend() and ride.get_yend()==newRide.get_yend :
                raise Exception("New ride is already in here. Try inputing a new one.")
        self._rideRepo.append(newRide)

    def list(self):
        value = "" if len(self._rideRepo) >0 else "The list is empty."
        for ride in self._rideRepo:
            value += (str(ride)+"\n")
        return value.rstrip()


