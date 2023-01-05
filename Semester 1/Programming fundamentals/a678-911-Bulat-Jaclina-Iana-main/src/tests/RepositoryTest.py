from src.repository.DisciplineRepository import DisciplineRepository
from src.repository.GradeRepository import GradeRepository
from src.repository.StudentRepository import StudentRepository

from src.domain.Discipline import Discipline
from src.domain.Grade import Grade
from src.domain.Student import Student

class RepositoryTest:
    def runTests(self):
        """
        Run al the tests
        """
        self.testDisciplineRepository()
        self.testGradeRepository()
        self.testStudentRepository()

    def testDisciplineRepository(self):
        """
        Test the DisciplineRepository class
        """
        disciplineRepo = DisciplineRepository()

        discipline1 = Discipline(0, "test1")
        discipline2 = Discipline(1, "test2")

        disciplineRepo.add(discipline1)
        disciplineRepo.add(discipline2)
        assert disciplineRepo.get_discRepo() == [discipline1, discipline2]

        disciplineRepo.remove(1)
        assert disciplineRepo.get_discRepo() == [discipline1]

        disciplineRepo.update(0, "test3")
        assert disciplineRepo.get_discRepo() == [Discipline(0, "test3")]


    def testGradeRepository(self):
        """
        Test the GradeRepository class
        """
        gradeRepo = GradeRepository()

        grade1 = Grade(0, 1, 5)
        grade2 = Grade(1, 2, 6)

        gradeRepo.addGrade(grade1)
        gradeRepo.addGrade(grade2)
        assert gradeRepo.get_gradeRepo() == [grade1, grade2]

        gradeRepo.removeStud(0)
        assert gradeRepo.get_gradeRepo() == [grade2]

        gradeRepo.removeDisc(2)
        assert gradeRepo.get_gradeRepo() == []

    def testStudentRepository(self):
        """
        Test the StudentRepository class
        """
        studentRepo = StudentRepository()

        student1 = Student(0, "test1")
        student2 = Student(1, "test2")

        studentRepo.add(student1)
        studentRepo.add(student2)
        assert studentRepo.get_student_repo() == [student1, student2]

        studentRepo.remove(1)
        assert studentRepo.get_student_repo() == [student1]

        studentRepo.update(0, "test3")
        assert studentRepo.get_student_repo() == [Student(0, "test3")]
