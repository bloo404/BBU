from src.domain.Discipline import Discipline
from src.domain.Grade import Grade
from src.domain.Student import Student

class DomainTest:
    def runTests(self):
        """
        Run all the tests
        """
        self.testDiscipline()
        self.testGrade()
        self.testStudent()

    def testDiscipline(self):
        """
        Test the Discipline class
        """
        discipline = Discipline(0, "Test")

        assert discipline.get_disciplineID() == 0
        assert discipline.get_name() == "Test"

        discipline.set_discipline_id(1)
        discipline.set_name("something")

        assert discipline.get_disciplineID() == 1
        assert discipline.get_name() == "something"

    def testGrade(self):
        """
        Test the Grade class
        """
        grade = Grade(0, 1, 2)

        assert grade.get_studentID() == 0
        assert grade.get_disciplineID() == 1
        assert grade.get_grade_value() == 2

        grade.set_student_id(3)
        grade.set_discipline_id(4)
        grade.set_grade_value(5)

        assert grade.get_studentID() == 3
        assert grade.get_disciplineID() == 4
        assert grade.get_grade_value() == 5

    def testStudent(self):
        """
        Test the Student class
        """
        student = Student(0, "Test")

        assert student.get_studentID() == 0
        assert student.get_name() == "Test"

        student.set_student_id(1)
        student.set_name("something")

        assert student.get_studentID() == 1
        assert student.get_name() == "something"
