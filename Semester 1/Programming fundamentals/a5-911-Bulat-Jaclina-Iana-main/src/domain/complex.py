class ComplexNumber:
    def __init__(self,real,imaginary):
        """
        Complex Number class is made of :
        :param real : float
        :param imaginary : float
        """
        if type(real) != float and type(real) !=int and type(imaginary)!=float and type(imaginary)!= int :
            raise ValueError("Put real numbers!")

        self.__realPart = real
        self.__imaginaryPart = imaginary

    def __eq__(self, other):
        return self.__realPart == other.__realPart and self.__imaginaryPart == other.__imaginaryPart

    @property
    def get_real(self):
       return self.__realPart

    @get_real.setter
    def set_real(self,value):
        self.__realPart = value

    @property
    def get_imaginary(self):
        return self.__imaginaryPart

    @get_imaginary.setter
    def set_imaginary(self,value):
        self.__imaginaryPart = value

    def __str__(self):
        return "Complex number | Real Part: " + str(self.__realPart) + " | Imaginary Part: " + str(self.__imaginaryPart) + "i"