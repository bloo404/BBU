class Taxi:
    def __init__(self,ID,x,y):
        self._ID = ID
        self._totalFare = 0
        self._x = x
        self._y = y

    def __eq__(self,newTaxi):
        return isinstance(newTaxi,Taxi) and self._ID == newTaxi.get_ID()

    def set_taxi_id(self, value):
        if value < 0:
            raise Exception("You should input a valid taxi ID.")
        self._ID = value

    def get_ID(self):
        return self._ID

    def set_totalFare(self,value):
        self._totalFare = value

    def get_totalFare(self):
        return self._totalFare

    def get_x(self):
        return self._x

    def get_y(self):
        return self._y

    def set_x(self,value):
        self._x = value

    def set_y(self,value):
        self._y = value

    def __str__(self):
       return str.ljust(50,self._ID) + str.rjust(1,self._totalFare) +"("+ str.rjust(1,self._x) + "," + str.rjust(1,self._y)+")"