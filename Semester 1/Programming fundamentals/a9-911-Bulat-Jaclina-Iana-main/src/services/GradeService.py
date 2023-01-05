from src.domain.Grade import Grade
from src.repository.ExceptionsRepository import ExceptionsRepository
from src.repository.StudentRepository import StudentRepository
from src.repository.StudentRepository import Student
from src.repository.DisciplineRepository import Discipline

from random import randint

class GradeService:
    """
    Service for rental operations
    """
    def __init__(self, gradeRepo, discRepo, studRepo):
        """
        Initialize the gradeService class
        :param gradeRepo: repository of grade objects
        :param disciplineRepo: repository of discipline objects
        :param studentRepo: repository of student objects
        """
        self.__gradeRepo = gradeRepo
        self.__discRepo = discRepo
        self.__studRepo = studRepo

        self.generate()

    def generate(self):
        """
        Generates a repository of 20 grades
        """
        students = list(range(20))
        disciplines = list(range(20))
        for iterator in range(20):
            student = randint(0,len(students)-1)
            discipline = randint(0,len(disciplines)-1)
            self.__gradeRepo.get_gradeRepo().append(Grade(students[student],disciplines[discipline],randint(1,10)))


    def filter_grades(self, student, discipline):
        """
        Grade filtering
        :param discipline: discipline object
        :return: filtered list
        """
        result = []
        for grade in self.__gradeRepo.get_gradeRepo():
            if student is not None and grade.get_studentID() != student:
                continue
            if discipline is not None and grade.get_disciplineID()!= discipline:
                continue
            result.append(grade)

        return result

    def create_grade(self, studentID,disciplineID, gradeValue):
        """
        Creating a grade
        :param studentID: integer, studentID
        :param disciplineID: integer, disciplineID
        :param gradeValue: float, grade value
        """
        grade = Grade(studentID,disciplineID,gradeValue)
        self.__gradeRepo.addGrade(grade)

    def remove_gradeDisc(self, discID):
        """
        :param gradeID: integer, discID
        """
        self.__gradeRepo.removeDisc(discID)

    def remove_gradeStud(self, studID):
        """
        :param gradeID: integer, studID
        """
        self.__gradeRepo.removeStud(studID)

    def remove_grade(self, studID, discID,gradeVal):
        """
        Removes a grade
        :param studID: integer, student ID
        :param discID: integer, discipline ID
        :param gradeVal: integer, value
        """
        self.__gradeRepo.remove(studID,discID,gradeVal)

    def list(self):
        """
        :return: a string containing the list of grades
        """
        return self.__gradeRepo.list()

    def statsFailure(self):
        """
        Statistics for failing students
        """
        for student in self.__studRepo.get_student_repo():
            counter = 0
            average2 = -1
            for discipline in self.__discRepo.get_discRepo():
                average = self.__gradeRepo.average(student.get_studentID(),discipline.get_disciplineID())
                if average < 5 and average!=0:
                    counter += 1
                    average2=average
            if counter > 0 and average2 >-1 :
                print("Student " + str(student)+"| Grade "+str(average2))

    def statsBest(self):
        """
        Statistics for the best students
        """
        value = int(0)
        stud = Student
        studentDict = {"Grade: ": value,"| Student:": stud}
        studentList = []
        for student in self.__studRepo.get_student_repo():
            counter = 0
            sum = 0
            for discipline in self.__discRepo.get_discRepo():
                average = self.__gradeRepo.average(student.get_studentID(), discipline.get_disciplineID())
                sum = sum + average
                if average != 0:
                    counter += 1
            if counter > 0:
                newAverage = sum/counter
                studentDict["Grade: "] = newAverage
                studentDict["| Student:"] = student
                studentDictCopy = studentDict.copy()
                studentList.append(studentDictCopy)
        newList = sorted(studentList, key = lambda i: i['Grade: '],reverse=True)
        for student in newList:
            print("Grade: " + str(student.get("Grade: ")) + "| Student: " + str(student.get("| Student:")))

    def discAvg(self):
        """
        Statistics for the average grades at a given discipline
        """
        value = int(0)
        disc = Discipline
        disciplineDict = {"Grade: ": value,"| Discipline:": disc}
        disciplineList = []
        for discipline in self.__discRepo.get_discRepo():
            counter = 0
            sum = 0
            for grade in self.__gradeRepo.get_gradeRepo():
                if discipline.get_disciplineID()==grade.get_disciplineID():
                    counter = counter + 1
                    sum = sum + grade.get_grade_value()
            if counter > 0:
                newAverage = sum/counter
                disciplineDict["Grade: "] = round(newAverage, 2)
                disciplineDict["| Discipline:"] = discipline
                discDictCopy = disciplineDict.copy()
                disciplineList.append(discDictCopy)
        newList = sorted(disciplineList, key = lambda i: i['Grade: '],reverse=True)
        for student in newList:
            print("Grade: " + str(student.get("Grade: ")) + "| Discipline: " + str(student.get("| Discipline:")))

