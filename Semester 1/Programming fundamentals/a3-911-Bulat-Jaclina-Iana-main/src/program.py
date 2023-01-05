"""
  Write non-UI functions below
"""
from datetime import date

today = date.today().day

if(today > 30 ) :
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
        self.__type = text

# Generating 10 transactions
def generateTransactions():
    return [createTransaction(1,50,'in','Gift Grandma'),createTransaction(1,25,'out','Pizza'),createTransaction(2,1200,'in','Salary'),
           createTransaction(3,600,'out','Rent'),createTransaction(3,100,'out','Gift Mom'),createTransaction(4,100,'out','Stocks'),
           createTransaction(5,2000,'in','2nd Salary'),createTransaction(5,500,'out','Bike'),createTransaction(6,600,'in','Sold bike'),
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
def addTransaction(transactionList,value,type,description):
    newTransaction = createTransaction(today,value,type,description)
    transactionList.append(newTransaction)

# The function that adds a transaction to the l=transaction list
def insertTransaction(transactionList,day,value,type,description):
    newTransaction = createTransaction(day,value,type,description)
    transactionList.append(newTransaction)

# Function that removes one transaction
def removeDay(transactionList, day):
    for transactions in transactionList :
        if transactions.get_day() == day :
            transactionList.remove(transactions)
            return True
    return False

# Function that removes all transaction in a day
def removeAllDay(transactionList,day):
    while(removeDay(transactionList,day)):
        removeDay(transactionList,day)

# Function that removes all transactions in a given range
def removeRange(transactionList,startDay,finishDay):
    trafficLight = 1
    while trafficLight == 1:
        trafficLight = 0
        for transactions in transactionList:
            if transactions.get_day() > startDay and transactions.get_day() < finishDay :
                transactionList.remove(transactions)
                trafficLight = 1

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
        if int(transactions.get_day()) == int(day) and transactions.get_type()==type and transactions.get_description() == description :
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
        if transactions.get_day()==day:
            if transactions.get_type() == 'in':
                sum = sum + transactions.get_amountOfMoney()
            if transactions.get_type() == 'out':
                sum = sum - transactions.get_amountOfMoney()
    return sum

# print(balanceDay(generateTransactions(),5))

# Function that adds a transaction to the transaction list from command
def addCommand(transactionList,commandParams,commandWord) :

    if commandWord=='add' :
        value,type,description = commandParams.split(" ")
        try :
            addTransaction(transactionList,value,type,description)
        except ValueError as ve:
            print(str(ve))
    if commandWord=='insert' :
        day,value,type,description = commandParams.split(" ")
        try :
            addTransaction(transactionList,value,type,description)
        except ValueError as ve:
            print(str(ve))

# Function that removes or replaces in the transaction list from command
def removeReplaceCommand(transactionList,commandParams,commandWord):
    if commandWord == 'remove' :
        tokens = commandParams.split(" ")
        if len(tokens) > 1 :
            firstDay = tokens[0]
            lastDay = tokens[2]
            removeRange(transactionList,firstDay,lastDay)
        if len(tokens) == 1 :
            if tokens[0] == 'in' or tokens[0]== 'out' :
                removingType(transactionList,tokens[0])
            else:
                removeAllDay(transactionList,tokens[0])
    if commandWord == 'replace' :
        day,type,description,value = commandParams.split(" ")
        replaceValue(transactionList,day,value,type,description)

# Function that shows the list from command
def showCommand(transactionList, commandParams):
    if commandParams == None :
        ShowAllTransactions(transactionList)
    else :
        tokens = commandParams.split(" ")
        print(tokens)
        if len(tokens) == 1:
            type = tokens[0]
            ShowTransactonsByType(transactionList,type)
        elif len(tokens) == 2:
            middle = tokens[0]
            value = tokens[1]
            print(middle)
            if middle == '>' :
                ShowTransactionsValueBigger(transactionList,value)
            elif middle == '=' :
                ShowTransactionsValueEqual(transactionList,value)
            elif middle == '<' :
                ShowTransactionsValueSmaller(transactionList,value)
            elif middle == 'balance' :
                print(balanceDay(transactionList,value)," is your balance.")
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
            insertTransaction(transactions,5,6,'in','Payed in cash for someone')
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

    transactions = generateTransactions()

    while True :
        print("What would you like to do today? ")
        command = input("> ")
        tokens = command.split(" ",maxsplit=1)
        commandWord = tokens[0]
        commandParams = None
        if len(tokens) > 1 :
            commandParams=tokens[1]
        # print(commandWord," ",commandParams)
        if commandWord=='add' or commandWord=='insert' and commandParams!=None :
            addCommand(transactions,commandParams,commandWord)
            ShowAllTransactions(transactions)
        elif commandWord=='remove' or 'replace' and commandParams!=None :
            removeReplaceCommand(transactions,commandParams,commandWord)
            ShowAllTransactions(transactions)
        elif commandWord=='list':
            showCommand(transactions,commandParams)
        elif commandWord=='exit':
            return
        else:
            print("You should introduce a valid command.")

startCommand()