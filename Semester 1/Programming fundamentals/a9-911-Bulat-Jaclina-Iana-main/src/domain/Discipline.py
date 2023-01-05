from src.domain.Exceptions import DisciplineException

class Discipline:
    """
    The class of disciplines
    """
    def __init__(self,discipline_id,name):
        """
        Initialization of the class
        :param discipline_id: integer, ID of the discipline
        :param name: string, name of the discipline
        """
        self.__discipline_id = -1
        self.set_discipline_id(discipline_id)

        self.__name=""
        self.set_name(name)

    def __str__(self):
        """
        :return: string, discipline id and name
        """
        return "ID: " + str(self.__discipline_id) + "| Discipline name: " + self.__name

    def __eq__(self, newDisc):
        """"
        :param newDisc : a new Discipline object
        :return true if the students have the same values, false in the other cases
        """
        return isinstance(newDisc, Discipline) and self.__discipline_id == newDisc.get_disciplineID()

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

    def set_name(self, value):
        """"
        Sets the name of the discipline with a given value
        :param value: string, name of the discipline
        """
        if len(value) == 0:
            raise DisciplineException("You should input a valid name.")
        self.__name = value

    def get_name(self):
        """
        Getter for the name
        :return: string, the name of the discipline
        """
        return self.__name