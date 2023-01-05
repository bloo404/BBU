class TaxiRepository:
    def __init__(self):
        self._taxiRepo = []

    def __len__(self):
        return len(self._taxiRepo)

    def get_taxiRepo(self):
        return self._taxiRepo

    def verifyTotalFare(self,taxi1,taxi2):
        if taxi1.get_totalFare()>taxi2.get_totalFare():
            return taxi1.get_totalFare()-taxi2.get_totalFare()
        else:
            return taxi2.get_totalFare()-taxi1.get_totalFare()

    def addTaxi(self,newTaxi):
        """
        Adds a new taxi to the repository
        :param newTaxi: Taxi object type
        """
        for taxi in self._taxiRepo :
            if taxi.get_ID() == newTaxi.get_ID() or self.verifyTotalFare(taxi,newTaxi)<=5:
                raise Exception("New taxi is already in here or the distance is too small between taxis.")
        self._taxiRepo.append(newTaxi)

    def list(self):
        value = "" if len(self._taxiRepo) >0 else "The list is empty."
        for taxi in self._taxiRepo:
            value += (str(taxi)+"\n")
        return value.rstrip()



