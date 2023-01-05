from src.domain.complex import ComplexNumber
import random

class Functions:
    def __init__(self):
        self.complexNumbersList = []
        self.history = []

    def addComplexNumber(self,real,imaginary):
        """
        Adds a complex number to the list
        :param real : integer or float number
        :param imaginary : integer or float number
        """
        self.complexNumbersList.append(ComplexNumber(real,imaginary))

    def get_ComplexNumberList(self):
        return self.complexNumbersList

    def generateComplexNumbers(self):
        """
            Generates 10 random complex numbers
        """
        number = 10
        while number > 0:
            a = random.randint(1,10)
            b = random.randint(11,20)
            self.complexNumbersList.append(ComplexNumber(a,b))
            number -= 1

    def listNumbers(self):
        """
            Displaying the whole list
        """
        newList = self.complexNumbersList
        for complex in newList :
            print(str(complex))

    def filterList(self,start,end):
        """
            Displaying the elements in specific range (filter)
            :param start : integer < end
            :param end : integer > start
        """
        for iterator in range(start ,end-1):
            print(str(self.complexNumbersList[iterator]))

    def addToHistory(self):
        """
            Adds to history last action
        """
        self.history.append(self.complexNumbersList[:])


    def deleteHistory(self):
        """"
            Undo
        """
        if len(self.history) == 0:
            print("You haven't done anything yet.")
        else:
            self.complexNumbersList.clear()
            self.complexNumbersList = self.history[len(self.history)-2]
            self.history.pop()

def runTest():
    testAdd()

def testAdd():
    newFunc = Functions()
    newFunc.addComplexNumber(1,2)
    newFunc.addComplexNumber(2,3)
    newFunc.addComplexNumber(3,4)
    complexList = newFunc.complexNumbersList[:]
    assert complexList[0].__eq__(ComplexNumber(1, 2))
    assert complexList[1].__eq__(ComplexNumber(2, 3))
    assert complexList[2].__eq__(ComplexNumber(3, 4))
    newFunc.complexNumbersList.clear()
