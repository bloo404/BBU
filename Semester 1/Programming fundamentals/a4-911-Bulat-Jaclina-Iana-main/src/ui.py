"""
  User interface module
"""

from functions import *

# Function that prints all transactions
from src import functions


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
        if int(transactions.get_amountOfMoney()) > int(value) :
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
            print(functions.balanceDay(transactionList,int(value))," is your balance.")
        else :
            print("Something is wrong in the typing. Verify and rewrite the command again.")
    else:
        print("Something is wrong in the typing. Verify and rewrite the command again.")

# Shows the type's sum of amount from all transactions
def ShowSumType(transactionList,commandParams,commandWord):
    sumIn, sumOut = functions.sumType(transactionList)
    if len(commandParams) == 1 :
        if commandParams[0]=='in':
            print("The sum of the ",commandParams[0]," type is : ",sumIn)
        elif commandParams[0]=='out':
            print("The sum of the ",commandParams[0]," type is : ",sumOut)
        else :
            print("Something is wrong in the typing. Verify and rewrite the command again.")
    else:
        print("Something is wrong in the typing. Verify and rewrite the command again.")

def ShowMax(transactionList,commandParams,commandWord):
    transaction = functions.maxTransaction(transactionList,commandParams,commandWord)
    if transaction == -1:
        print("No maximum transaction found for that day. Try on another day.")
    elif transaction != -1 :
        print("The maximum transaction found is : ",transaction.get_amountOfMoney()," , ",transaction.get_description())
    else:
        print("Something is wrong in the typing. Verify and rewrite the command again.")

def ShowFilteredByType(transactionList,commandParams):
    transactions = functions.filterType(transactionList,commandParams)
    ShowAllTransactions(transactions)

def ShowFilteredByTypeValue(transactionList,commandParams):
    transactions = functions.filterValue(transactionList,commandParams)
    ShowAllTransactions(transactions)

def UndoCommand(transactionList,historyStack):
    if len(historyStack) > 0  :
        functions.undo(transactionList,historyStack)
    else:
        print("You did not do anything yet!")

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

    transactions = functions.generateTransactions()

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
            functions.removingType(transactions,'out')
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
