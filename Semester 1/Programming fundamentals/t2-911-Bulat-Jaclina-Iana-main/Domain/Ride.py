class Ride:
    def __init__(self,xstart,ystart,xend,yend):
        self._xStart = xstart
        self._yStart = ystart
        self._xEnd = xend
        self._yEnd = yend

    def __eq__(self,newRide):
        return isinstance(newRide,Ride) and self._xStart == newRide.get_xstart() and self._yStart == newRide.get_ystart() and self._xEnd == newRide.get_xend() and self._yEnd == newRide.get_yend()

    def set_xstart(self,value):
        self._xStart = value

    def set_ystart(self,value):
        self._yStart = value

    def set_xend(self,value):
        self._xEnd = value

    def set_yend(self,value):
        self._yEnd = value

    def get_xstart(self):
        return self._xStart

    def get_xend(self):
        return self._xEnd

    def get_yend(self):
        return self._yEnd

    def get_ystart(self):
        return self._yStart

    def __str__(self):
       return "(" + str.ljust(50,self._ID) + ","+  str.rjust(1,self._totalFare)+")"