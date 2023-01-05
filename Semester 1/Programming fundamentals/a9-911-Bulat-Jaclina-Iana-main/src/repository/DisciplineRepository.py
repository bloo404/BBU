from src.domain.Discipline import Discipline
from src.repository.ExceptionsRepository import ExceptionsRepository
from random import randint

class DisciplineRepository:
    """
    Class for discipline repository
    """
    def __init__(self):
        """
        Initiliaze the Discipline repository class
        """
        self.__disciplineRepo = []

    def __len__(self):
        return len(self.__disciplineRepo)

    def get_discRepo(self):
        """
        :return: repository list
        """
        return self.__disciplineRepo

    def add(self, newDiscipline):
        """
        Add a new discipline
        :param newDiscipline: string, new discipline name
        """
        for discipline in self.__disciplineRepo:
            if discipline.get_disciplineID() == newDiscipline.get_disciplineID():
                raise ExceptionsRepository("Discipline already exists! Enter a new ID.")
        self.__disciplineRepo.append(newDiscipline)

    def searchDisc(self,data):
        """
        Searches a discipline by given data
        :param discipline_id: string, data of the discipline
        :return: discipline if it exists, message otherwise
        """
        result = [str(disc) for disc in self.__disciplineRepo if disc.get_name().lower().startswith(data.lower()) or
                  str(disc.get_disciplineID()).startswith(data)]
        if len(result) > 0:
            return result
        return "There is no discipline with given data."

    def searchDiscByID(self, ID):
        """
        Searches a discipline by a given id
        :param ID: integer, ID
        :return: integer, id
        """
        result = ID
        if ID > 0:
            return ID
        return "There is no discipline with this ID."

    def update(self, discipline_id, name):
        """
        Updates a discipline with a new name
        :param discipline_id: integer, ID of the discipline you want to update
        :param name: string, the new name
        """

        for disc in self.__disciplineRepo:
            if disc.get_disciplineID() == discipline_id:
                disc.set_name(name)

    def remove(self, discipline_id):
        """
        Remove a discipline by a given ID
        :param discipline_id: integer, ID of the discipline you want to remove
        """
        for discipline in self.__disciplineRepo:
            if discipline.get_disciplineID() == discipline_id :
                self.__disciplineRepo.remove(discipline)
                return None
        raise ExceptionsRepository("No discipline with given ID found. Try again.")

    def list(self):
        """
        List all the disciplines
        :return:
        """
        value = "" if len(self.__disciplineRepo) > 0 else "The list of disciplines is empty."
        for discipline in self.__disciplineRepo:
            value += (str(discipline) + "\n")

        return value.rstrip()