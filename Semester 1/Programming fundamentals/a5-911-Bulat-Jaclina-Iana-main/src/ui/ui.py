from src.services.functions import Functions
from src.services.functions import *

class Console:
    def __init__(self):
        self._functions = Functions()

    def showMenu(self):
        print("")
        print("- COMPLEX NUMBERS MENU -")
        print("1. Add a complex number")
        print("2. Display all numbers")
        print("3. Filter the list")
        print("4. Undo")
        print("5. Exit")
        print("")

    def getValues(self):
        real = int(input("Real part : "))
        imaginary = int(input("Imaginary part : "))
        self._functions.addComplexNumber(real,imaginary)
        print("Complex number added.")

    def generateNumbers(self):
        self._functions.generateComplexNumbers()

    def displayList(self):
        self._functions.listNumbers()

    def filter(self):
        start = int(input("Start point (int number) : "))
        end = int(input("End point (int number) : "))
        if end - start == 1 :
            print("Range too small.")
        else:
            print(str(self._functions.filterList(start,end)))

    def undo(self):
        self._functions.deleteHistory()
        print("Your actual list is : ")
        self._functions.listNumbers()

    def start(self):
        runTest()
        self.generateNumbers()
        while True :
            try :
                self.showMenu()
                print("What would you like to do today ? ")
                option = int(input())
                if option == 1 :
                    self._functions.addToHistory()
                    self.getValues()
                elif option == 2 :
                    self.displayList()
                elif option == 3 :
                    self.filter()
                elif option == 4 :
                    self.undo()
                elif option == 5 :
                    return
            except ValueError:
                print("Write a valid input!")

console = Console()
console.start()