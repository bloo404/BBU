from unittest import TestCase
from src.repository.DisciplineRepository import DisciplineRepository
from src.repository.DisciplineRepository import Discipline


class TestDisciplineRepository(TestCase):

    def test_add(self):
        disciplineRepo = DisciplineRepository()
        discipline1 = Discipline(0, "test1")
        discipline2 = Discipline(1, "test2")

        disciplineRepo.add(discipline1)
        disciplineRepo.add(discipline2)
        self.assertEqual(disciplineRepo.get_discRepo(),[discipline1,discipline2])

    def test_search_disc(self):
        disciplineRepo = DisciplineRepository()
        discipline1 = Discipline(0, "test1")
        discipline2 = Discipline(1, "test2")

        disciplineRepo.add(discipline1)
        disciplineRepo.add(discipline2)
        self.assertEqual(disciplineRepo.searchDisc(0),str(discipline1))

    def test_update(self):
        disciplineRepo = DisciplineRepository()
        discipline1 = Discipline(0, "test1")
        discipline2 = Discipline(1, "test2")

        disciplineRepo.add(discipline1)
        disciplineRepo.add(discipline2)
        self.assertEqual(disciplineRepo.get_discRepo(),[discipline1, discipline2])

        disciplineRepo.remove(1)
        self.assertEqual(disciplineRepo.get_discRepo(),[discipline1])

        disciplineRepo.update(0, "test3")
        self.assertEqual(disciplineRepo.get_discRepo(),[Discipline(0, "test3")])

    def test_remove(self):
        disciplineRepo = DisciplineRepository()
        discipline1 = Discipline(0, "test1")
        discipline2 = Discipline(1, "test2")

        disciplineRepo.add(discipline1)
        disciplineRepo.add(discipline2)
        self.assertEqual(disciplineRepo.get_discRepo(),[discipline1, discipline2])

        disciplineRepo.remove(1)
        self.assertEqual(disciplineRepo.get_discRepo(),[discipline1])
