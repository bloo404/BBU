""""
                            Function section
                (write all non-UI functions in this section)
    There should be no print or input statements below this comment
    Each function should do one thing only
    Functions communicate using input parameters and their return values
"""

# Creating a complex number
def createComplexNumber(numberId,realPart,imagPart) :
    if len(numberId)<1 :
        return None
    return {'id' : numberId, 'realPart' : realPart, 'imagPart' : imagPart}

# Returns a complex number's ID
def get_id(complexNumber) :
    return complexNumber['id']

# Returns the real part of a complex number
def get_real(complexNumber) :
    return complexNumber['realPart']

# Returns the imaginary part of a complex number
def get_imaginary(complexNumber) :
    return complexNumber['imagPart']

# Generates 10 complex numbers
def generateComplexNumbers() :
    return [createComplexNumber('1',5,6),createComplexNumber('2',7,8),createComplexNumber('3',30,0),createComplexNumber('4',26,-8),
            createComplexNumber('5',7,9),createComplexNumber('6',-10,0),createComplexNumber('7',34,0),createComplexNumber('8',18,0),
            createComplexNumber('9',10,7),createComplexNumber('10',8,-9)]

# Adds a complex number to the list
def addComplexNumber(complexNumberList, complexNumber) :
    #searches for the given id
    for c in complexNumberList :
        if get_id(complexNumber) == get_id(c) :
            return False
    #adds the complex number to the list
    complexNumberList.append(complexNumber)
    return True

# Squared module of a complex number
def moduleComplexNumber(complexNumberList,complexNumberID) :
    complexNumberReal = get_real(complexNumberList[complexNumberID])
    complexNumberImag = get_imaginary(complexNumberList[complexNumberID])
    module = complexNumberReal*complexNumberReal + complexNumberImag*complexNumberImag

# Longest sequence with real numbers (no imaginary part)
def sequenceRealNumbers(complexNumberList) :
    first = int(0)
    last = int(0)
    longest = int(0)
    length = len(complexNumberList)
    i = int(0)
    while i < length :
        if get_imaginary(complexNumberList[i])==0 :
            cont  = 0
            first2 = i
            while get_imaginary(complexNumberList[i])==0 :
                i = i + 1
                cont = cont + 1
            if cont > longest :
                longest = cont
                first = first2
                last = first + cont - 1
        i = i + 1
    return first,last

# Longest sequence with complex number's modules that are in [0,10] range
# Squared modules meaning the [0,100] range
def sequenceModuleNumbers(complexNumberList) :
    first = int(0)
    last = int(0)
    longest = int(0)
    length = len(complexNumberList)
    i = int(0)
    while i < length :
        if moduleComplexNumber(complexNumberList,i)==0 :
            cont  = 0
            first2 = i
            while moduleComplexNumber(complexNumberList,i)>=0 and moduleComplexNumber(complexNumberList,i)<=100 :
                i = i + 1
                cont = cont + 1
            if cont > longest :
                longest = cont
                first = first2
                last = first + cont - 1
        i = i + 1
    return first,last

""""
                                    UI section
            (write all functions that have input or print statements here). 
    Ideally, this section should not contain any calculations relevant to program functionalities
"""

# The menu function
def printMenu() :
    print("1. Add a complex number")
    print("2. Show all complex numbers")
    print("3. Show a complex number by ID")
    print("4. Show the longest sequence with real numbers")
    print("5. Show the longest sequence with the modulus of all elements in the [0,10] range")
    print("6. Exit the application")

# Reading what to add in the list of complex numbers
def addComplexNumberUI(complexNumberList) :
    complexNumberId = input("Complex Number ID : ")
    complexNumberReal = int(input("Complex number real part : "))
    complexNumberImag = int(input("Complex number imaginary part : "))

    complexNumber = createComplexNumber(complexNumberId,complexNumberReal,complexNumberImag)
    if complexNumber is None :
        print("Cannot add a complex number")
        return

    if not addComplexNumber(complexNumberList,complexNumber):
        print("Duplicate complex number id")

# Prints all complex numbers
def showAllNumbers(complexNumberList) :
    # sorting by id numbers
    # complexNumberList.sort(key=get_real)
    for complexNumber in complexNumberList :
        print(get_id(complexNumber),str(get_real(complexNumber))+' +',str(get_imaginary(complexNumber))+'i')

# Prints only the longest sequence with real numbers
def showSequenceReal(complexNumberList) :
    first,last = sequenceRealNumbers(complexNumberList)
    if first==0 and last==0 :
        print("A sequence with this property was not found.")
        print(" Choose another option or add another number.")
    for index in range(first,last+1) :
       print('(',get_real(complexNumberList[index]),',',get_imaginary(complexNumberList[index]),')')

# Prints the longest sequence with the squared module in the [0,100] range
def showSequenceModule(complexNumberList) :
    first,last = sequenceModuleNumbers(complexNumberList)
    if first==0 and last==0 :
        print("A sequence with this property was not found.")
        print(" Choose another option or add another number.")
    for index in range(first,last+1) :
       print('(',get_real(complexNumberList[index]),',',get_imaginary(complexNumberList[index]),')')

# Shows a complex numebr by its ID
def showComplexNumber(complexNumberList) :
    complexNumberID = input("Enter the ID of the number you want to show: ")
    ok = int(0)
    for complexNumber in complexNumberList :
        if get_id(complexNumber) == str(complexNumberID) :
            print('(',get_real(complexNumber),',',get_imaginary(complexNumber),')')
            ok = 1
            break
    if ok==0 :
        print("ID not found")

# The start function that plays the whole program
def start() :
    # Generating 10 numbers
    complexNumbersList = generateComplexNumbers()

    while True :
        printMenu()
        option = input("Enter your option : ")

        if option == '1' :
            addComplexNumberUI(complexNumbersList)
        elif option == '2' :
            showAllNumbers(complexNumbersList)
        elif option == '3' :
            showComplexNumber(complexNumbersList)
        elif option == '4' :
            showSequenceReal(complexNumbersList)
        elif option == '5' :
            showSequenceModule(complexNumbersList)
        elif option == '6' :
            return
        else :
            print("Invalid option")

start()
