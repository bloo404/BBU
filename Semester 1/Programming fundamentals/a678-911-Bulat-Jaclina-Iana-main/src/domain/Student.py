from src.domain.Exceptions import StudentException

class Student :
    """
    The Student class
    """
    def __init__(self,student_id,name):
        """"
        :param student_id: integer, the ID of the student
        :param name: string, name of the student
        """
        self.__student_id = -1
        self.set_student_id(student_id)

        self.__name=""
        self.set_name(name)

    def __str__(self):
        """"
        :return string, student id and name
        """
        return "ID: " + str(self.__student_id) + "| Name: " + self.__name

    def __eq__(self, newStud):
        """"
        :param newStud : a new Student object
        :return true if the students have the same values, false in the other cases
        """
        return isinstance(newStud,Student) and self.__student_id == newStud.get_studentID()

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

    def set_name(self, value):
        """"
        Sets the name of the student with a given value
        :param value: string, name of the student
        """
        if len(value) == 0:
            raise StudentException("You should input a valid name.")
        self.__name = value

    def get_name(self):
        """
        Getter for the name
        :return: string, the name of the student
        """
        return self.__name