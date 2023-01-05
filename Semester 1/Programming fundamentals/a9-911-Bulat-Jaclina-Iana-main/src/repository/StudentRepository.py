from src.domain.Student import Student
from src.repository.ExceptionsRepository import ExceptionsRepository
from src.repository.GradeRepository import GradeRepository
from random import randint

class StudentRepository:
    """
    The student class Repository
    """
    def __init__(self):
        """
        Initializing the student repository
        """
        self.__studentRepo = []

    def get_student_repo(self):
        """
        Getter for the repository
        :return: list of objects
        """
        return self.__studentRepo

    def add(self,newStudent):
        """
        Add a new student to the list
        :param newStudent: student object, new object
        """
        for student in self.__studentRepo:
            if student.get_studentID() == newStudent.get_studentID():
                raise ExceptionsRepository("It already exists!")
        self.__studentRepo.append(newStudent)

    def remove(self, student_id):
        """
        Removes a student from the list
        :param student_id: integer, student ID
        """
        for student in self.__studentRepo:
            if student.get_studentID()==student_id:
                self.__studentRepo.remove(student)
                return None
        raise ExceptionsRepository("Student with given ID not found.")

    def update(self,student_id,newName):
        """
        :param student_id: integer, ID of the student that we want to update
        :param newName: string, the new name for this student
        """
        for student in self.__studentRepo:
            if student.get_studentID()==student_id:
                student.set_name(newName)
                return None
        raise ExceptionsRepository("Student with given ID not found.")

    def list(self):
        """
        Prints the list of objects that exist
        :return: list of objects, string representation of the elements in the repository
        """
        value = ""
        for student in self.__studentRepo:
            value += (str(student) + "\n")

        return value.rstrip()

    def searchStud(self,data):
        """
        Searches a student by given data
        :param studentID: string, student data
        :return: details about that student, messsage otherwise
        """
        result = [str(stud) for stud in self.__studentRepo if
                  stud.get_name().lower().startswith(data.lower()) or str(stud.get_studentID()).startswith(data)]
        if len(result) > 0:
            return result
        return "There is no student with given data."

    def searchStudByID(self, ID):
        """
        Searches a student by ID
        :param ID: integer, ID
        :return: integer, ID
        """
        result = ID
        if ID > 0:
            return ID
        return "There is no student with this ID."
