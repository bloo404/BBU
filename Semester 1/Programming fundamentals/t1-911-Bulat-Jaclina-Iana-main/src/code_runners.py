import random
from random import *
import time

def createRandomNumber(number):
    return{'Number' : number}

def get_Number(RandomNumber):
    return RandomNumber['Number']

def generateRandomNumber():
    """"
        Generate a random number
        :returns a valid random number of four digits with distinct digits
    """
    tl = 0
    while(tl == 0):
        number = randrange(1,9)
        number = number*10 + randrange(0,9)
        number = number * 10 + randrange(0, 9)
        number = number * 10 + randrange(0, 9)
        frequency = [0,0,0,0,0,0,0,0,0,0]
        for index in range(0,10):
            frequency[index] = 0
        digit1 = int(number % 10)
        digit2 = int((number / 10) % 10)
        digit3 = int((number / 100)%10)
        digit4 = int((number / 1000)%10)
        frequency[digit1]= frequency[digit1] + 1
        frequency[digit2] = frequency[digit2] + 1
        frequency[digit3] = frequency[digit3] + 1
        frequency[digit4] = frequency[digit4] + 1
        tl = 1
        for index in range(0,10):
            if frequency[index] > 1 :
                tl = 0
    if tl == 1 :
        return number

def isValid(number):
    frequency = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for index in range(0, 10):
        frequency[index] = 0
    digit1 = int(number % 10)
    digit2 = int((number / 10) % 10)
    digit3 = int((number / 100) % 10)
    digit4 = int((number / 1000) % 10)
    frequency[digit1] = frequency[digit1] + 1
    frequency[digit2] = frequency[digit2] + 1
    frequency[digit3] = frequency[digit3] + 1
    frequency[digit4] = frequency[digit4] + 1
    for index in range(0, 10):
        if frequency[index] > 1:
            return 0
    return 1

def CodesAndRunners(number1,number2):
    digit1 = int(number1 % 10)
    digit2 = int((number1 / 10) % 10)
    digit3 = int((number1 / 100) % 10)
    digit4 = int((number1 / 1000) % 10)
    digi1 = int(number2 % 10)
    digi2 = int((number2 / 10) % 10)
    digi3 = int((number2 / 100) % 10)
    digi4 = int((number2 / 1000) % 10)
    codes = int(0)
    runners = int(0)
    frequency1 = [0,0,0,0,0,0,0,0,0,0]
    frequency2 = [0,0,0,0,0,0,0,0,0,0]
    for index in range(0, 10):
        if frequency1[index] == frequency2[index] and frequency1[index]!=0 :
            codes = codes + 1
    if digit2 == digi1 or digit2==digi3 or digit2==digi4 :
        runners = runners + 1
    if digit1 == digi2 or digit1==digi3 or digit1==digi4 :
        runners = runners + 1
    if digit3 == digi2 or digit3==digi1 or digit3==digi4 :
        runners = runners + 1
    if digit4 == digi2 or digit4==digi3 or digit4==digi1 :
        runners = runners + 1
    return codes,runners

def printMenu():
    print("1. Start the game")
    print("2. Exit the game")



def startCommand():

    newRandomNumber = generateRandomNumber()

    sec = 60

    while True:
        newRandomNumber = generateRandomNumber()
        print("Insert a number: ")
        command = input("> ")
        tokens = command.split(" ", maxsplit=1)
        commandWord = int(tokens[0])
        commandParams = None
        if len(tokens) > 1:
            commandParams = tokens[1]
        if isValid(commandWord):
            if commandWord!=str(8086):
                codes,runners = CodesAndRunners(int(commandWord),newRandomNumber)
                print( codes," Codes and ",runners," Runners")
            else :
                print(newRandomNumber)
        else:
            print("Computer wins!")



# print(generateRandomNumber())
# print(CodesAndRunners(1234,2345))
# print(isValid(8823))
startCommand()