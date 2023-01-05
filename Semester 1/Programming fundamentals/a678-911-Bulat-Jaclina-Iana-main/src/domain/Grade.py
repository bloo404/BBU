from src.domain.Exceptions import GradeException
from src.domain.Exceptions import DisciplineException
from src.domain.Exceptions import StudentException

class Grade:
    """
    Class Grade that represents the grades that a student can get at a discipline
    """
    def __init__(self, student_id, discipline_id, grade_value):
        """
        Parameters for the initialization :
        :param student_id: integer, student ID
        :param discipline_id: integer, discipline ID
        :param grade_value: float, grade value
        """

        self.__grade_value = -1
        self.set_grade_value(grade_value)

        self.__student_id = -1
        self.set_student_id(student_id)

        self.__discipline_id = -1
        self.set_discipline_id(discipline_id)

    def __str__(self):
        """
        String with all details of a grade
        :return: string
        """
        return "Student ID: " + str(self.__student_id) + " | Discipline ID: " + str(self.__discipline_id) + " | Grade: " + str(self.__grade_value)

    def set_grade_value(self,value):
        """
        Setter for the grade value
        :param value: float, value of the grade
        """
        if value < 0:
            raise GradeException("Enter a valid grade >= 0.")
        self.__grade_value = value

    def get_grade_value(self):
        """
        :return: float, grade value
        """
        return self.__grade_value

    def set_student_id(self,value):
        """
        Setter for the student ID
        :param value: integer, new ID
        """
        if value < 0 :
            raise StudentException("You should input a valid ID.")
        self.__student_id = value

    def get_studentID(self):
        """
        Gets the student ID
        :return: integer, id of the student
        """
        return self.__student_id

    def set_discipline_id(self,value):
        """
        Setter for the discipline ID
        :param value: integer, new ID
        """
        if value < 0 :
            raise DisciplineException("You should input a valid ID.")
        self.__discipline_id = value

    def get_disciplineID(self):
        """
        Gets the discipline ID
        :return: integer, id of the discipline
        """
        return self.__discipline_id
