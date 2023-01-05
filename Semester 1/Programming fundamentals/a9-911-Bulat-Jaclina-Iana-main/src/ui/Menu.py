from src.domain.Exceptions import *
from src.repository.ExceptionsRepository import *
from functools import partial

class Menu:
    """
    The menu class we re gonna use
    """
    def __init__(self, studServ, gradServ, discServ, stackService):
        """
        Initializing the menu class
        :param studServ: student service object
        :param gradServ: grades service object
        :param discServ: discipline service object
        """
        self.__studServ = studServ
        self.__gradServ = gradServ
        self.__discServ = discServ
        self.__stackServ = stackService

        self.__menuOptions = ["Exit", "Add a discipline", "Remove a discipline", "Update a discipline", "List disciplines",
                               "Add a student", "Remove a student", "Update a student", "List students",
                               "Grade a student","List grades","Search for disciplines","Search for students","Statistics: students failing",
                              "Statistics: students with base school situation","Statistics: Disciplines by average grades","Undo","Redo"]

    def display_menu(self):
        """
        Shows the menu
        """
        while True:
            for i in range(len(self.__menuOptions)):
                print((" " if i < 17 else "") + str(i) + ". " + self.__menuOptions[i])
            print()

            option = Menu.get_input("Option: ")

            if option == 0:
                print("Quitting.\n")
                input("Press any key to continue.")

                return None

            self.handle_menuOptions(option)

    def handle_menuOptions(self, option):
        """
        Handles the given menu option using the list of complex numbers
        :param option: The menu option that was selected by the user
        """
        try:
            if option == 1:
                disciplineID = Menu.get_input("Discipline ID: ")
                name = input("Name: ")
                self.__stackServ.addToUndo((partial(self.__discServ.create,disciplineID,name),
                                            partial(self.__discServ.delete,disciplineID)))
                self.__discServ.create(disciplineID,name)
                print("You have added a new discipline.")

            elif option == 2:
                discipline_id = Menu.get_input("Discipline ID: ")
                self.__stackServ.addToUndo((partial(self.__discServ.delete, discipline_id),
                                               partial(self.__discServ.create, discipline_id,self.__discServ.searchDiscID(discipline_id))))
                self.__discServ.delete(discipline_id)
                print("You have deleted a discipline.")

            elif option == 3:
                disciplineID = Menu.get_input("Discipline ID: ")
                name = input("Name: ")
                oldName = self.__discServ.searchDiscID(disciplineID)
                self.__stackServ.addToUndo((partial(self.__discServ.update, disciplineID,name),
                                            partial(self.__discServ.update, disciplineID,oldName)))
                self.__discServ.update(disciplineID,name)
                print("You have updated the discipline.")

            elif option == 4:
                print(self.__discServ.list())

            elif option == 5:
                studentID = Menu.get_input("Student ID: ")
                name = input("Name: ")
                self.__stackServ.addToUndo((partial(self.__studServ.create, studentID, name),
                                            partial(self.__studServ.delete, studentID)))
                self.__studServ.create(studentID, name)
                print("You have added a new student.")

            elif option == 6:
                studentID = Menu.get_input("Student ID: ")
                self.__stackServ.addToUndo((partial(self.__studServ.delete, studentID),
                                            partial(self.__studServ.create, studentID,
                                                    self.__studServ.searchStudID(studentID))))
                self.__studServ.delete(studentID)
                print("You have deleted a student.")

            elif option == 7:
                studentID = Menu.get_input("Student ID: ")
                name = input("New Name: ")
                oldName = self.__studServ.searchDiscID(studentID)
                self.__stackServ.addToUndo((partial(self.__studServ.update, studentID, name),
                                            partial(self.__studServ.update, studentID, oldName)))
                self.__studServ.update(studentID, name)
                print("You have updated the student.")

            elif option == 8:
                print(self.__studServ.list())

            elif option == 9:
                discID = Menu.get_input("Discipline ID: ")
                studentID = Menu.get_input("Student ID: ")
                gradeValue = Menu.get_input("Grade value: ")
                self.__stackServ.addToUndo((partial(self.__gradServ.create_grade, studentID,discID, gradeValue),
                                            partial(self.__gradServ.remove_grade, studentID,discID,gradeValue )))
                self.__gradServ.create_grade(studentID,discID,gradeValue)
                print("You have added a grade.")

            elif option == 10:
                print(self.__gradServ.list())

            elif option == 11:
                readInfo = Menu.get_string("Discipline data: ")
                print(self.__discServ.search(readInfo))

            elif option == 12:
                readInfo = Menu.get_string("Student data: ")
                print(self.__studServ.search(readInfo))

            elif option == 13:
                self.__gradServ.statsFailure()

            elif option == 14:
                self.__gradServ.statsBest()

            elif option == 15:
                self.__gradServ.discAvg()

            elif option == 16:
                self.__stackServ.undoFunction()

            elif option == 17:
                self.__stackServ.redoFunction()

        except (DisciplineException,StudentException,GradeException,ExceptionsRepository) as error:
            print("ERROR: " + str(error))
        except ValueError:
            print("ERROR: Invalid parameter type!")
        except IndexError:
            print("ERROR: Invalid index!")

        print()
        input("Press any key to continue.")

    @staticmethod
    def get_input(prompt):
        """
        :param prompt: the prompt that is shown to the user for input
        :return: a valid integer
        """
        while True:
            try:
                value = int(input(prompt))
                return value
            except ValueError:
                print()
                print("ERROR: Invalid input! Try again.")

    @staticmethod
    def get_string(prompt):
        """
            :param prompt: the prompt that is shown to the user for input
            :return: a valid string
        """
        while True:
            try:
                value = str(input(prompt))
                return value
            except ValueError:
                print()
                print("ERROR: Invalid input! Try again.")
