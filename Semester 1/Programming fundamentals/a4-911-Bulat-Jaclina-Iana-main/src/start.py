"""
  Start the program by running this module
"""

from functions import *
from ui import *

# Function that works with commands on the list
def startCommand():
    runTests()

    transactions = generateTransactions()
    historyStack = []
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
                    addToStack(transactions, historyStack)
                    addCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'insert':
                if len(commandParams) != 4:
                    raise KeyError
                else:
                    addToStack(transactions, historyStack)
                    addCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'remove':
                addToStack(transactions, historyStack)
                if len(commandParams) != 1 and len(commandParams) != 3:
                    raise KeyError
                else:
                    addToStack(transactions, historyStack)
                    removeReplaceCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'replace':
                if len(commandParams) != 5:
                    raise KeyError
                else:
                    addToStack(transactions, historyStack)
                    removeReplaceCommand(transactions, commandParams, commandWord)
                    ShowAllTransactions(transactions)
            elif commandWord == 'list':
                if len(commandParams) > 2:
                    raise KeyError
                else:
                    showCommand(transactions, commandParams)
            elif commandWord == 'sum':
                if len(commandParams) > 1:
                    raise KeyError
                else:
                    ShowSumType(transactions,commandParams, commandWord)
            elif commandWord == 'max':
                if len(commandParams) != 2 :
                    raise KeyError
                else:
                    ShowMax(transactions,commandParams,commandWord);
            elif commandWord == 'filter':
                if len(commandParams) < 1  or len(commandParams) > 2:
                    raise KeyError
                elif len(commandParams)==1 :
                    ShowFilteredByType(transactions,commandParams)
                else :
                    ShowFilteredByTypeValue(transactions,commandParams)
            elif commandWord == 'undo':
                UndoCommand(transactions,historyStack)
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
