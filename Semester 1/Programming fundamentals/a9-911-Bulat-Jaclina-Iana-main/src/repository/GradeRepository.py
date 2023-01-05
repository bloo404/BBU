from src.domain.Grade import Grade
from src.repository.ExceptionsRepository import ExceptionsRepository
from random import randint

class GradeRepository:
    """
    Class that defines grades repository
    """
    def __init__(self):
        """
        Initializing the Grade Repository
        """
        self.__gradeRepo = []

    def get_gradeRepo(self):
        """
        Getter for the repository
        :return: list of grades
        """
        return self.__gradeRepo

    def addGrade(self, grade):
        """
        Add a new grade
        :param grade: the new grade
        """
        self.__gradeRepo.append(grade)

    def removeStud(self,student_id):
        """
        Remove a grade by its student_id
        :param grade_id: integer, student ID
        """
        for grade in self.__gradeRepo:
            if grade.get_studentID() == student_id:
                self.__gradeRepo.remove(grade)
                return None

        raise ExceptionsRepository("There is no grade for the student with the given ID!")

    def removeDisc(self,discID):
        """
        Remove a grade by its discipline_id
        :param grade_id: integer, discipline ID
        """
        for grade in self.__gradeRepo:
            if grade.get_disciplineID() == discID:
                self.__gradeRepo.remove(grade)
                return None

        raise ExceptionsRepository("There is no grade for the student with the given ID!")


    def list(self):
        """
        :return: list of grades
        """
        value = ""
        for grade in self.__gradeRepo:
            value += (str(grade) + "\n")

        return value.rstrip() #removes spaces

    def average(self,studentID,discID):
        """
        Calculates the average grade for a student at a given discipline
        :param studentID: integer, student id
        :param discID: integer, discipline id
        :return: average grade for that discipline
        """
        sum = 0
        count = 0
        for grade in self.__gradeRepo:
            if grade.get_studentID()==studentID and grade.get_disciplineID()==discID:
                sum += grade.get_grade_value()
                count = count + 1
        if count==0:
            return 10
        return sum/count

    def remove(self,student_id, discipline_id,gradeValue):
        """
        Removes a grade from the repo
        :param student_id: integer, student ID
        :param discipline_id: integer, discipline ID
        :param gradeValue: integer, grade value
        """
        for grade in self.__gradeRepo:
            if grade.get_studentID() == student_id and grade.get_disciplineID()==discipline_id\
                    and grade.get_grade_value()==gradeValue:
                self.__gradeRepo.remove(grade)
                return None
        raise ExceptionsRepository("No discipline with given ID found. Try again.")


        