from src.ui.Menu import Menu

from src.domain.Grade import Grade
from src.domain.Student import Student
from src.domain.Discipline import Discipline
from src.domain.Exceptions import StudentException, GradeException, DisciplineException

from src.repository.GradeRepository import GradeRepository
from src.repository.StudentRepository import StudentRepository
from src.repository.DisciplineRepository import DisciplineRepository
from src.repository.ExceptionsRepository import ExceptionsRepository

from src.services.StudentService import StudentService
from src.services.GradeService import GradeService
from src.services.DisciplineService import DisciplineService
from src.services.StackService import StackService

from src.tests.DomainTest import DomainTest
from src.tests.RepositoryTest import RepositoryTest

def main():
    domainTest = DomainTest()
    repositoryTest = RepositoryTest()

    domainTest.runTests()
    repositoryTest.runTests()

    studentRepo = StudentRepository()
    discRepo = DisciplineRepository()
    gradeRepo = GradeRepository()

    gradeServ = GradeService(gradeRepo,discRepo,studentRepo)
    studentServ = StudentService(studentRepo,gradeServ)
    discServ = DisciplineService(discRepo,gradeServ)
    stackServ = StackService(gradeRepo)

    menu = Menu(studentServ,gradeServ,discServ,stackServ)
    menu.display_menu()

if __name__ == '__main__':
    main()