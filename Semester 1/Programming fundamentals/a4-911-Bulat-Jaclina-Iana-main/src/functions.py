"""
  Program functionalities module
"""

from datetime import date

from src import ui
from ui import *

today = date.today().day
if today > 30:
    today = 1

# Creating a transaction by user
def createTransaction(day,amountOfMoney,type,description):
    """
       Create transaction
       :param day: day (must not be empty)
       :param amountOfMoney: Amount (bigger than 0)
       :param type: type (in or out)
       :param description : description (must not be empty)
       :return: Transaction
       :except ValueError in case transaction could not be created
    """
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

    def __eq__(self, other):
        return self.__day == other.__day and self.__amountOfMoney == other.__amountOfMoney and \
               self.__type == other.__type and self.__description.lower() == other.__description.lower()

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
    testAddTransaction()
    testInsertTransactions()
    testRemoveRange()
    testRemoveType()
    testRemoveDayTransaction()
    testRemoveAllDaysTransactions()
    testReplaceValue()
    testBalanceDay()
    testBalanceCalculator()
    testSumType()
    testMaxTransaction()
    testFilterValue()
    testFilterType()
    testAddStack()
    testUndo()

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

def testAddTransaction():
    transactionsList = [createTransaction(1,50,'in','Gift_Grandma')]
    addTransaction(transactionsList,20,'out','test',2)

    assert transactionsList[0].__eq__(createTransaction(1,50,'in','Gift_Grandma')) and \
           transactionsList[1].__eq__(createTransaction(2,20,'out','test'))

    addTransaction(transactionsList,50,'in','test2',3)

    assert transactionsList[0].__eq__(createTransaction(1,50,'in','Gift_Grandma')) and \
           transactionsList[1].__eq__(createTransaction(2,20,'out','test')) and \
           transactionsList[2].__eq__(createTransaction(3,50,'in','test2'))

    addTransaction(transactionsList,200,'in','test3',4)

    assert transactionsList[0].__eq__(createTransaction(1, 50,'in','Gift_Grandma')) and \
           transactionsList[1].__eq__(createTransaction(2, 20,'out','test')) and \
           transactionsList[2].__eq__(createTransaction(3, 50,'in','test2')) and \
           transactionsList[3].__eq__(createTransaction(4, 200,'in','test3'))

def testInsertTransactions():
    transactionsList = [createTransaction(1,50,'in','Gift_Grandma')]
    addTransaction(transactionsList,20,'out','test',2)

    assert transactionsList[0].__eq__(createTransaction(1,50,'in','Gift_Grandma')) and \
           transactionsList[1].__eq__(createTransaction(2,20,'out','test'))

    addTransaction(transactionsList,50,'in','test2',3)

    assert transactionsList[0].__eq__(createTransaction(1,50,'in','Gift_Grandma')) and \
           transactionsList[1].__eq__(createTransaction(2,20,'out','test')) and \
           transactionsList[2].__eq__(createTransaction(3,50,'in','test2'))

    addTransaction(transactionsList,200,'in','test3',1)
    assert transactionsList[0].__eq__(createTransaction(1,50,'in','Gift_Grandma')) and \
           transactionsList[1].__eq__(createTransaction(1,200,'in','test3')) and \
           transactionsList[2].__eq__(createTransaction(2,20,'out','test')) and \
           transactionsList[3].__eq__(createTransaction(3,50,'in','test2'))

def testRemoveDayTransaction():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]

    removeDay(transactionsList,1)
    assert transactionsList==[transaction2,transaction3,transaction4,transaction5]

    removeDay(transactionsList,2)
    assert transactionsList==[transaction3,transaction4,transaction5]

    removeDay(transactionsList,3)
    assert transactionsList==[transaction3,transaction5]

def testRemoveAllDaysTransactions():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]

    removeAllDay(transactionsList,1)
    assert transactionsList==[transaction2,transaction3,transaction4,transaction5]

    removeAllDay(transactionsList,2)
    assert transactionsList==[transaction4,transaction5]

    removeAllDay(transactionsList,3)
    assert transactionsList==[transaction5]

def testRemoveRange():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
    removeRange(transactionsList,1,2)
    assert transactionsList==[transaction4,transaction5]

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
    removeRange(transactionsList,2,3)
    assert transactionsList==[transaction1,transaction5]

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
    removeRange(transactionsList,3,4)
    assert transactionsList==[transaction1,transaction2,transaction3]

def testRemoveType():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
    removingType(transactionsList,'in')
    assert transactionsList==[transaction2,transaction4]

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
    removingType(transactionsList,'out')
    assert transactionsList==[transaction1,transaction3,transaction5]

def testReplaceValue():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    transactionsList=[transaction1,transaction2,transaction3]

    replaceValue(transactionsList,1,200,'in','gift_grandma')
    assert transactionsList[0].__eq__(createTransaction(1,200,'in','Gift_Grandma'))

    replaceValue(transactionsList,2,300,'out','pizza')
    assert transactionsList[1].__eq__(createTransaction(2,300,'out','Pizza'))

    replaceValue(transactionsList,2,400,'in','salary')
    assert transactionsList[2].__eq__(createTransaction(2,400,'in','Salary'))

def testBalanceCalculator():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3]
    assert balanceCalculator(transactionsList)==1225

    transactionsList=[transaction1,transaction2,transaction3,transaction4]
    assert balanceCalculator(transactionsList)==625

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
    assert balanceCalculator(transactionsList)==725

def testBalanceDay():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3]
#    assert balanceDay(transactionsList,1)==50

    transactionsList=[transaction1,transaction2,transaction3,transaction4]
#    assert balanceDay(transactionsList,2)==1225

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]
#    assert balanceDay(transactionsList,3)==625

def testSumType():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]

    sumIn, sumOut = sumType(transactionsList)
    assert sumIn == 1350
    assert sumOut == 625

def testMaxTransaction():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(1,250,'in','Salary')
    transaction3=createTransaction(1,50,'out','Beauty')
    transaction4=createTransaction(1,600,'out','Rent')

    transactionsList=[transaction1,transaction2,transaction3, transaction4]

    assert maxTransaction(transactionsList,['in',1],'max').__eq__(transaction2)
    assert maxTransaction(transactionsList,['out',1],'max').__eq__(transaction4)

def testFilterValue():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]

    filtered=filterValue(transactionsList, ['in', 200])
    assert filtered==[transaction1,transaction5]

    filtered=filterValue(transactionsList, ['out', 50])
    assert filtered==[transaction2]

def testFilterType():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    transaction4=createTransaction(3,600,'out','Rent')
    transaction5=createTransaction(4,100,'in','Gift_Mom')

    transactionsList=[transaction1,transaction2,transaction3,transaction4,transaction5]

    filtered=filterType(transactionsList, ['in'])
    assert filtered==[transaction1,transaction3,transaction5]

    filtered=filterType(transactionsList, ['out'])
    assert filtered==[transaction2,transaction4]

def testAddStack():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')
    historyStack=[]

    transactionsList=[transaction1]
    addToStack(transactionsList,historyStack)
    assert historyStack==[[transaction1]]

    transactionsList=[transaction1,transaction2]
    addToStack(transactionsList,historyStack)
    assert historyStack==[[transaction1],[transaction1,transaction2]]

    transactionsList=[transaction1,transaction2,transaction3]
    addToStack(transactionsList,historyStack)
    assert historyStack==[[transaction1],[transaction1,transaction2],[transaction1,transaction2,transaction3]]

def testUndo():
    transaction1=createTransaction(1,50,'in','Gift_Grandma')
    transaction2=createTransaction(2,25,'out','Pizza')
    transaction3=createTransaction(2,1200,'in','Salary')

    historyStack=[[transaction1], [transaction1, transaction2], [transaction1, transaction2, transaction3]]
    transactionsList=[]

    undo(transactionsList, historyStack)
    assert transactionsList==[transaction1, transaction2, transaction3]
    assert historyStack==[[transaction1], [transaction1, transaction2]]

    undo(transactionsList, historyStack)
    assert transactionsList==[transaction1, transaction2]
    assert historyStack==[[transaction1]]

    undo(transactionsList, historyStack)
    assert transactionsList==[transaction1]
    assert historyStack==[]

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
    """
       Add transaction
       :param transactionList: A list of transactions (must not be empty)
       :param Value: Amount (bigger than 0)
       :param type: type (in or out)
       :param description : description (must not be empty)
       :param day=today : value of today
    """
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
    """
        Insert transaction
        :param transactionList: list of transactions (must not be empty)
        :param day: Day (range from 1 to 30)
        :param value: Amount (bigger than 0)
        :param type: type (in or out)
        :param description : description (must not be empty)
    """
    newTransaction = createTransaction(day,value,type,description)
    transactionList.append(newTransaction)

# Function that removes one transaction
def removeDay(transactionList, day):
    """
        Remove day
        :param transactionList: list of transactions (must not be empty)
        :param day: Day (range from 1 to 30)
    """
    for transactions in transactionList :
        if int(transactions.get_day()) == int(day) :
            transactionList.remove(transactions)
            return True
    return False

# Function that removes all transaction in a day
def removeAllDay(transactionList,day):
    """
        Remove transactions from a day
        :param transactionList: list of transactions (must not be empty)
        :param day: Day (range from 1 to 30)

    """
    while(removeDay(transactionList,day)):
        pass

# Function that removes all transactions in a given range
def removeRange(transactionList,startDay,finishDay):
    """
        Remove transactions within range
        :param transactionList: list of transactions (must not be empty)
        :param startDay: Day (range from 1 to 30)
        :param finishDay: Day (bigger than startDay, maximum 30)

    """
    for iterator in range(len(transactionList) - 1, -1, -1):
        if int(transactionList[iterator].get_day()) >= startDay and int(transactionList[iterator].get_day()) <= finishDay:
            transactionList.remove(transactionList[iterator])

# Function that removes all transactions whitin a type
def removingType(transactionList,type):
    """
        Remove transactions of a type
        :param transactionList: list of transactions (must not be empty)
        :param type: type (in or out)

    """
    trafficLight = 1
    while trafficLight == 1 :
        trafficLight = 0
        for transactions in transactionList :
            if transactions.get_type() == type :
                transactionList.remove(transactions)
                trafficLight = 1

# Function that replaces a value in a specific transaction
def replaceValue(transactionList,day,value,type,description):
    """
        Replace values in transaction list by day,value,type,description
        :param transactionList: A list of transactions (must not be empty)
        :param day : Day
        :param Value: Amount (bigger than 0)
        :param type: type (in or out)
        :param description : description (must not be empty)
        :return True if it replaced the value,False if it has not been found

    """
    for transactions in transactionList :
        if int(transactions.get_day()) == int(day) and transactions.get_type()==type and transactions.get_description().lower() == description.lower() :
            transactions.set_amountOfMoney(value)
            return True
    return False

# Function that calculates the total balance of the account
def balanceCalculator(transactionList) :
    """
        Balance calculator
        :param transactionList: A list of transactions (must not be empty)
        :return the balance(negative if the user ahs taken out more than introduced in its account)

    """
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
    """
        Balance in a day
        :param transactionList: A list of transactions (must not be empty)
        :param day : day (range 1 to 30)
        :return the balance(negative if the user ahs taken out more than introduced in its account)

    """
    sum = int(0)
    for transactions in transactionList:
        if transactions.get_day()> day:
            break
        else:
            if transactions.get_type() == 'in':
                sum = sum + transactions.get_amountOfMoney()
            if transactions.get_type() == 'out':
                sum = sum - transactions.get_amountOfMoney()
    return sum

# print(balanceDay(generateTransactions(),5))

# Function that adds a transaction to the transaction list from command
def addCommand(transactionList,commandParams,commandWord) :
    """
        Add command
        :param transactionList: A list of transactions (must not be empty)
        :param commandParams: List of parameters
        :param commandWord: Command Word

    """
    if commandWord=='add' :
        value,type,description = commandParams[0], commandParams[1], commandParams[2]
        addTransaction(transactionList,value,type,description)
    if commandWord=='insert' :
        day,value,type,description = commandParams[0], commandParams[1], commandParams[2], commandParams[3]
        addTransaction(transactionList,value,type,description, int(day))

# Function that removes or replaces in the transaction list from command
def removeReplaceCommand(transactionList,commandParams,commandWord):
    """
        Remove Replace command
        :param transactionList: A list of transactions (must not be empty)
        :param commandParams: List of parameters
        :param commandWord: Command Word

    """
    if commandWord == 'remove' :
        if len(commandParams) == 1:
            if commandParams[0] == 'in' or commandParams[0]== 'out' :
                removingType(transactionList,commandParams[0])
            else:
                removeAllDay(transactionList,commandParams[0])
        elif len(commandParams) == 3 :
            firstDay = commandParams[0]
            lastDay = commandParams[2]
            removeRange(transactionList,int(firstDay),int(lastDay))
        else:
            print("The command couldn't be found.")
    elif commandWord == 'replace' :
        day,type,description,value = commandParams[0], commandParams[1], commandParams[2], commandParams[4]
        replaceValue(transactionList,day,int(value),type,description)
    else:
        print("The command couldn't be found.")

# Calculating the sums of both types
def sumType(transactionList):
    """
        Sum of type transactions
        :param transactionList: A list of transactions (must not be empty)
        :return sum of In transactions and sum of Out transactions

    """
    sumIn = int(0)
    sumOut = int(0)
    for transactions in transactionList:
        if transactions.get_type() == 'in' :
            sumIn = sumIn + transactions.get_amountOfMoney()
        if transactions.get_type() == 'out' :
            sumOut = sumOut + transactions.get_amountOfMoney()
    return sumIn,sumOut

# Returning the max transaction of a type in a day
def maxTransaction(transactionList, commandParams, commandWord) :
    """
        The maximum transaction in a day by type
        :param transactionList: A list of transactions (must not be empty)
        :param commandParams: List of command parameters (must not be empty)
        :param commandWord: Command Word (single string)
        :return Maximum transaction Object if found, -1 if not found

    """
    transactionMax = createTransaction(commandParams[1],1,commandParams[0],'Max transaction')
    tl = 0
    for transactions in transactionList :
        if transactions.get_amountOfMoney() > transactionMax.get_amountOfMoney() and int(transactions.get_day())==int(commandParams[1]) and transactions.get_type()==commandParams[0]:
            transactionMax = transactions
            tl = 1
    if transactionMax.get_amountOfMoney() != 0 and tl==1:
        return transactionMax
    else:
        return -1

# It filters the transaction list by type
def filterType(transactionList,commandParams):
    """
        Filter by type
        :param transactionList: A list of transactions (must not be empty)
        :param commandParams : List of parameters (list of strings)
        :return Returns list of transactions with that type

    """
    transactionsType = transactionList[:]
    if commandParams[0]=='in':
        removingType(transactionsType,'out')
    else:
        removingType(transactionsType,'in')
    return transactionsType

# It filters the transaction list by type and value
def filterValue(transactionList,commandParams):
    """
        Filter by type and value
        :param transactionList: A list of transactions (must not be empty)
        :param commandParams : List of parameters (list of strings)
        :return Returns list of transactions with that type and with smaller values

    """
    transactions = filterType(transactionList,commandParams)
    for iterator in range(len(transactions) - 1, -1, -1):
        if transactions[iterator].get_amountOfMoney() >= int(commandParams[1]):
            transactions.remove(transactions[iterator])

    return transactions

# Adding to the history the list before it
def addToStack(transactionsList,historyStack):
    """
        Add to history stack the last list
        :param transactionsList: A list of transactions (must not be empty)
        :param historyStack: A list of the lists (must not be empty)

    """
    historyStack.append(transactionsList[:])

# Deleting from history the actual list and updating the list before
def undo(transactionsList,historyStack):
    """
        Undo
        :param transactionsList: A list of transactions (must not be empty)
        :param historyStack: A list of the lists (must not be empty)

    """
    transactionsList.clear()
    for transaction in historyStack[len(historyStack) - 1]:
        transactionsList.append(transaction)
    historyStack.pop()



