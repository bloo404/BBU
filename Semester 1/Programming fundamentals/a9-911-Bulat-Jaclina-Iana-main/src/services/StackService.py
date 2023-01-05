from functools import partial

class StackService:
    """
    Class that manages the undo/redo functionalities
    """
    def __init__(self, gradeRepo):
        """
        Constructor for the StackService class
        """
        self.__gradeRepo = gradeRepo
        self.__undoStack = []
        self.__redoStack = []

    def addToUndo(self,function):
        """
        Adds the function that can be undoed
        Redo shouldn t work because they didn t undo so they can redo
        :param function: string, a function call
        :return:
        """
        self.__redoStack.clear()
        self.__undoStack.append(function)

    def undoFunction(self):
        """
        Undoes the last done function
        """
        if len(self.__undoStack) == 0:
            raise IndexError("The undo stack is empty. Do something so you can undo.")

        self.__redoStack.append(self.__undoStack[-1])
        self.__undoStack[-1][1]()
        if len(self.__undoStack[-1])==3:
            for grade in self.__redoStack[-1][2]:
                self.__gradeRepo.get_gradeRepo().append(grade)

        self.__undoStack.pop()

    def redoFunction(self):
        """
        Redoes the previous operation that has been undone
        """
        if len(self.__redoStack) == 0:
            raise IndexError("You haven't undone so you could redo. Undo something first.")

        self.__undoStack.append(self.__redoStack[-1])

        self.__redoStack[-1][0]()
        self.__redoStack.pop()