from src.domain.Discipline import Discipline

from random import randint

class DisciplineService:
    """
    Discipline services class
    """
    def __init__(self,discRepo,gradeService):
        """
        Initializer for the discipline service class
        :param discRepo: Discipline Repository object
        :param gradeService: Grade Service object
        """
        self.__discRepo = discRepo
        self.__gradeService = gradeService

        self.generate()

    def generate(self):
        """
        Generate 20 random elements in the repository
        """
        discNames = ["Basic Math","CS","CSA","Romanian","Music","Graphic design","Sport","Physics","Astronomy","Analysis","Algebra","Goldbach theories","Java","Logic","Computational Logic","Chemistry","Assisted graphic","Hardware","Basic Biology","Anatomy","CPR"]
        for iterator in range(20):
            self.__discRepo.get_discRepo().append(Discipline(iterator,discNames[randint(0,len(discNames)-1)]))


    def create(self,discipline_id,name):
        """
        Create the repository of disciplines
        :param discipline_id: integer, discipline ID
        :param grades: all existent grades for that discipline
        """
        discipline = Discipline(discipline_id,name)
        self.__discRepo.add(discipline)

    def delete(self,discipline_id):
        """
        Deletes a discipline from the "database"
        :param discipline_id: integer, discipline ID
        """
        self.__discRepo.remove(discipline_id)

        grades = self.__gradeService.filter_grades(None, discipline_id)
        for grade in grades:
            self.__gradeService.remove_gradeDisc(discipline_id)

    def search(self,data):
        """
        Searches a discipline by a given data
        :param data: string, data about the discipline
        :return: discipline if it exists, otherwise a message
        """
        result = self.__discRepo.searchDisc(data)
        if result!="There is no discipline with given data.":
            for res in result:
                print(str(res))
        else:
            return result

    def searchDiscID(self,ID):
        """
        Searches a discipline by given ID
        :param ID: integer, discipline's ID
        :return: name of the discipline
        """
        data = self.__discRepo.searchDiscByID(ID)
        if data != "There is no discipline with this ID.":
            for discipline in self.__discRepo.get_discRepo():
                if discipline.get_disciplineID() == data:
                    return discipline.get_name()

    def update(self,discipline_id,name):
        """
        Update a discipline
        :param discipline_id: integer, discipline ID
        :param name: string, new name
        """
        self.__discRepo.update(discipline_id,name)

    def list(self):
        """
        Returns the list
        :return: list of objects
        """
        return self.__discRepo.list()

