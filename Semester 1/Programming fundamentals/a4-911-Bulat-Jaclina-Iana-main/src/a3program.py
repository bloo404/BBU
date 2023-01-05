"""
  Write non-UI functions below
"""
from datetime import date

today = date.today().day
if today > 30:
    today = 1

# Creating a transaction by user
def createTransaction(day,amountOfMoney,type,description):

    if (int(day) < 1 or int(day)>30) or (type!='in' and type!='out') or description=='' or int(amountOfMoney) <=0 :
        raise ValueError('Cannot create transaction using given data!')
    return Transaction(day,amountOfMoney,type,description)

# Defining a transaction
class Transaction:

    def __init__(self, day=0, amountOfMoney = 0, type='off', description=''):
        self.__day = day
        self.__amountOfMoney = amountOfMoney
        self.__type = type
        self.__description = description

    def get_day(self):
        return self.__day

    def get_amountOfMoney(self):
        return self.__amountOfMoney

    def get_type(self):
        return self.__type

    def get_description(self):
        return self.__description

    def set_day(self, value):
        self.__day = value

    def set_amountOfMoney(self, value):
        self.__amountOfMoney = value

    def set_type(self, kind):
        self.__type = kind

    def set_description(self, text):
        self.__description = text

# Function that runs the tests
def runTests():
    #run the tests
    testGetDay()
    testSetDay()
    testGetAmountOfMoney()
    testSetAmountOfMoney()
    testGetType()
    testSetType()
    testGetDescription()
    testSetDescription()

# Tests for getters and setters

def testGetDay():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    assert transaction1.get_day()==1
    assert transaction2.get_day()==1
    assert transaction3.get_day()==2

def testSetDay():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    transaction1.set_day(3)
    transaction2.set_day(4)
    transaction3.set_day(5)

    assert transaction1.get_day()==3
    assert transaction2.get_day()==4
    assert transaction3.get_day()==5

def testGetAmountOfMoney():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    assert transaction1.get_amountOfMoney()==50
    assert transaction2.get_amountOfMoney()==25
    assert transaction3.get_amountOfMoney()==1200

def testSetAmountOfMoney():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    transaction1.set_amountOfMoney(100)
    transaction2.set_amountOfMoney(200)
    transaction3.set_amountOfMoney(300)

    assert transaction1.get_amountOfMoney()==100
    assert transaction2.get_amountOfMoney()==200
    assert transaction3.get_amountOfMoney()==300

def testGetType():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    assert transaction1.get_type()=='in'
    assert transaction2.get_type()=='out'
    assert transaction3.get_type()=='in'

def testSetType():
    transaction1=createTransaction(1, 50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    transaction1.set_type('out')
    transaction2.set_type('in')
    transaction3.set_type('out')

    assert transaction1.get_type()=='out'
    assert transaction2.get_type()=='in'
    assert transaction3.get_type()=='out'

def testGetDescription():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    assert transaction1.get_description()=='Gift_Grandma'
    assert transaction2.get_description()=='Pizza'
    assert transaction3.get_description()=='Salary'

def testSetDescription():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    transaction1.set_description('test1')
    transaction2.set_description('test2')
    transaction3.set_description('test3')

    assert transaction1.get_description()=='test1'
    assert transaction2.get_description()=='test2'
    assert transaction3.get_description()=='test3'

# Generating 10 transactions
def generateTransactions():
    return [createTransaction(1,50,'in','Gift_Grandma'),createTransaction(1,25,'out','Pizza'),createTransaction(2,1200,'in','Salary'),
           createTransaction(3,600,'out','Rent'),createTransaction(3,100,'out','Gift_Mom'),createTransaction(4,100,'out','Stocks'),
           createTransaction(5,2000,'in','2nd_Salary'),createTransaction(5,500,'out','Bike'),createTransaction(6,600,'in','Sold_Bike'),
           createTransaction(7,100,'out','Investment')]

# Testing the transaction object
# uwu = Transaction()
#
# uwu.set_day(16)
#
# print(uwu.get_day())
# uwu.set_day(10)
# print(uwu.set_day)

# The function that adds a transaction on today's date to the transaction list
def addTransaction(transactionList,value,type,description,day=today):
    newTransaction = createTransaction(day,value,type,description)
    if day == today:
        transactionList.append(newTransaction)
    else:
        dayIndex=-1
        for iterator in range(len(transactionList)):
            if int(transactionList[iterator].get_day())==day:
                dayIndex = iterator

            if dayIndex != -1 and int(transactionList[iterator].get_day())!=day:
                break

        if dayIndex != -1:
            transactionList.insert(dayIndex + 1, newTransaction)
        else:
            transactionList.append(newTransaction)

# The function that adds a transaction to the l=transaction list
def insertTransaction(transactionList,day,value,type,description):
    newTransaction = createTransaction(day,value,type,description)
    transactionList.append(newTransaction)

# Function that removes one transaction
def removeDay(transactionList, day):
    for transactions in transactionList :
        if int(transactions.get_day()) == int(day) :
            transactionList.remove(transactions)
            return True
    return False

# Function that removes all transaction in a day
def removeAllDay(transactionList,day):
    while(removeDay(transactionList,day)):
        pass

# Function that removes all transactions in a given range
def removeRange(transactionList,startDay,finishDay):
    for iterator in range(len(transactionList) - 1, -1, -1):
        if int(transactionList[iterator].get_day()) >= startDay and int(transactionList[iterator].get_day()) <= finishDay:
            transactionList.remove(transactionList[iterator])

# Function that removes all transactions whitin a type
def removingType(transactionList,type):
    trafficLight = 1
    while trafficLight == 1 :
        trafficLight = 0
        for transactions in transactionList :
            if transactions.get_type() == type :
                transactionList.remove(transactions)
                trafficLight = 1

# Function that replaces a value in a specific transaction
def replaceValue(transactionList,day,value,type,description):
    for transactions in transactionList :
        if int(transactions.get_day()) == int(day) and transactions.get_type()==type and transactions.get_description().lower() == description :
            transactions.set_amountOfMoney(value)
            return True
    return False

# Function that calculates the total balance of the account
def balanceCalculator(transactionList) :
    sum = int(0)
    for transactions in transactionList :
        if transactions.get_type()=='in' :
            sum = sum + transactions.get_amountOfMoney()
        if transactions.get_type()=='out' :
            sum = sum - transactions.get_amountOfMoney()
    return sum

# print(balanceCalculator(generateTransactions()))

# Function that calculates the balance for a specific day
def balanceDay(transactionList,day):
    sum = int(0)
    for transactions in transactionList:
        if transactions.get_day()> day:
            break
        if transactions.get_type() == 'in':
            sum = sum + transactions.get_amountOfMoney()
        if transactions.get_type() == 'out':
            sum = sum - transactions.get_amountOfMoney()
    return sum

# print(balanceDay(generateTransactions(),5))

# Function that adds a transaction to the transaction list from command
def addCommand(transactionList,commandParams,commandWord) :

    if commandWord=='add' :
        value,type,description = commandParams[0], commandParams[1], commandParams[2]
        addTransaction(transactionList,value,type,description)
    if commandWord=='insert' :
        day,value,type,description = commandParams[0], commandParams[1], commandParams[2], commandParams[3]
        addTransaction(transactionList,value,type,description, int(day))

# Function that removes or replaces in the transaction list from command
def removeReplaceCommand(transactionList,commandParams,commandWord):
    if commandWord == 'remove' :
        if len(commandParams) == 1:
            if commandParams[0] == 'in' or commandParams[0]== 'out' :
                removingType(transactionList,commandParams[0])
            else:
                removeAllDay(transactionList,commandParams[0])
        if len(commandParams) == 3 :
            firstDay = commandParams[0]
            lastDay = commandParams[2]
            removeRange(transactionList,int(firstDay),int(lastDay))
    if commandWord == 'replace' :
        day,type,description,value = commandParams[0], commandParams[1], commandParams[2], commandParams[4]
        replaceValue(transactionList,day,int(value),type,description)

# Function that shows the list from command
def showCommand(transactionList, commandParams):
    if len(commandParams) == 0:
        ShowAllTransactions(transactionList)
        return None

    if len(commandParams) == 1:
        type = commandParams[0]
        if type != "out" and type != "in":
            print("Invalid type!")
        else:
            ShowTransactonsByType(transactionList,type)
    elif len(commandParams) == 2:
        middle = commandParams[0]
        value = commandParams[1]
        print(middle)
        if middle == '>' :
            ShowTransactionsValueBigger(transactionList,int(value))
        elif middle == '=' :
            ShowTransactionsValueEqual(transactionList,int(value))
        elif middle == '<' :
            ShowTransactionsValueSmaller(transactionList,int(value))
        elif middle == 'balance' :
            print(balanceDay(transactionList,int(value))," is your balance.")
        else :
            print("Something is wrong in the typing. Verify and rewrite the command again.")
    else:
        print("Something is wrong in the typing. Verify and rewrite the command again.")



"""
  Write the command-driven UI below
"""

# Function that prints all transactions
def ShowAllTransactions(transactionsList) :
    # for transactions in transactionsList :
    #     for transactions2 in transactionsList :
    #         if transactions2.get_day() < transactions.get_day() :
    #             aux = Transaction()
    #             aux = transactions
    #             transactions = transactions2
    #             transactions2 = aux
    #

    for transactions in transactionsList :
        print("Day: ",transactions.get_day(),"| Amount: ",transactions.get_amountOfMoney(),"| Type: ",transactions.get_type(),"| Description: ",transactions.get_description())

# Function that displays transactions within a type
def ShowTransactonsByType(transactionsList, type):
    for transactions in transactionsList :
        if transactions.get_type()==type :
            print("Day: ", transactions.get_day(), "| Amount: ", transactions.get_amountOfMoney(), "| Type: ",
                  transactions.get_type(), "| Description: ", transactions.get_description())

# Function that displays transactions bigger than a value
def ShowTransactionsValueBigger(transactionsList, value) :
    for transactions in transactionsList :
        if transactions.get_amountOfMoney() > value :
            print("Day: ", transactions.get_day(), "| Amount: ", transactions.get_amountOfMoney(), "| Type: ",
                  transactions.get_type(), "| Description: ", transactions.get_description())

# Function that displays transactions smaller than a value
def ShowTransactionsValueSmaller(transactionsList, value) :
    for transactions in transactionsList :
        if transactions.get_amountOfMoney() < value :
            print("Day: ", transactions.get_day(), "| Amount: ", transactions.get_amountOfMoney(), "| Type: ",
                  transactions.get_type(), "| Description: ", transactions.get_description())

# Function that displays transactions equal to a value
def ShowTransactionsValueEqual(transactionsList, value) :
    for transactions in transactionsList :
        if int(transactions.get_amountOfMoney()) == int(value) :
            print("Day: ", transactions.get_day(), "| Amount: ", transactions.get_amountOfMoney(), "| Type: ",
                  transactions.get_type(), "| Description: ", transactions.get_description())

# Prints the menu
def printMenu():
    print("1. Add a transaction to current day.")
    print("2. Add a transaction to a specific day.")
    print("3. Remove all transactions in a specific day.")
    print("4. Remove all transactions in a range of days.")
    print("5. Remove all transactions with a type. (in or out)")
    print("6. Modify the value of a transaction.")
    print("7. Show all transactions.")
    print("8. Show all transactions with a type. (in or out)")
    print("9. Show all transactions with a value >,< or = to a specific value.")
    print("10. Show the balance of your account.")
    print("11. Exit")

# Function that I used for tests that works like a menu
def startMenu():

    transactions = generateTransactions()

    while True:
        printMenu()

        option = input("Enter option =")

        if option == '1':
            addTransaction(transactions,16,'in',"Testing smth")
        elif option == '2':
            insertTransaction(transactions,5,6,'in','Paid in cash for someone')
        elif option == '3':
            removeAllDay(transactions,5)
        elif option == '4':
            removeRange(transactions,1,4)
        elif option == '5':
            removingType(transactions,'out')
        elif option == '6':
            replaceValue(transactions,2,2000,'in','Salary')
        elif option == '7':
            ShowAllTransactions(transactions)
        elif option == '8':
            ShowTransactonsByType(transactions,'out')
        elif option == '9':
            ShowTransactionsValueBigger(transactions,1000)
            print("Ended bigger")
            ShowTransactionsValueEqual(transactions,2000)
            print("Ended equal")
            ShowTransactionsValueSmaller(transactions,1000)
            print("Ended smaller")
        elif option == '10':
            print(balanceCalculator(transactions)," is your balance.")
        elif option == '11':
            return
        else:
            print("Invalid option!")

#startMenu()

# Function that works with commands on the list
def startCommand():
    runTests()

    transactions = generateTransactions()
    while True:
        try:
            print("What would you like to do today?")
            command = input("> ")

            tokens = ' '.join(command.split()).lower().split()
            commandWord = tokens[0]
            commandParams = tokens[1:]

            if commandWord == 'add':
                if len(commandParams) != 3:
                    raise KeyError
                else:
                    addCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'insert':
                if len(commandParams) != 4:
                    raise KeyError
                else:
                    addCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'remove':
                if len(commandParams) != 1 and len(commandParams) != 3:
                    raise KeyError
                else:
                    removeReplaceCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'replace':
                if len(commandParams) != 5:
                    raise KeyError
                else:
                    removeReplaceCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'list':
                if len(commandParams) > 2:
                    raise KeyError
                else:
                    showCommand(transactions, commandParams)
            elif commandWord == 'exit':
                return
            else:
                print("You should introduce a valid command.")
        except KeyError:
            print("Invalid number of parameters!\n")
        except ValueError:
            print("Invalid parameter type!\n")
        except IndexError:
            print("Invalid index provided!\n")

startCommand()
