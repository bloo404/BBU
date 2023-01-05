from src.domain.Student import Student

from random import randint

class StudentService:
    def __init__(self, studentrepo, gradeServ):
        """
        Initializer of the student service
        :param studentrepo: StudentRepository object
        :param gradeServ: gradeService object
        """
        self.__studentRepo = studentrepo
        self.__gradeServ = gradeServ

        self.generateList()

    def generateList(self):
        """
        Generates a repository with 20 random students
        """
        surName = ["Agnes","Adelina","Aurelian","Crina","Clara","Elisabeta","Natasa","Serafima","Iosif","Gheorghe","Constantin","David","Mihai","Mircea","Stephan"]
        firstName = ["Iancu","Popescu","Borza","Babes-Bolyai","Popoviciu","Blaga","Lazar","Batran","Bostane","Placinta","Budinca","Alergie","Ciocolata","Florea","Anthurium","Crizantema","Muscata"]

        for iterator in range(20):
            self.__studentRepo.get_student_repo().append(Student(iterator,surName[randint(0, len(surName)-1)] + " " + firstName[randint(0,len(firstName)-1)] ))


    def create(self, studentID,name):
        """
        Creates a student
        :param studentID: integer, studentID
        :param name: string, name of the student
        """
        student = Student(studentID,name)
        self.__studentRepo.add(student)

    def delete(self,studentID):
        """
        Delete a student by ID
        :param studentID: integer, studentID
        """
        self.__studentRepo.remove(studentID)

        grades = self.__gradeServ.filter_grades(studentID, None)
        for grade in grades:
            self.__gradeServ.remove_gradeStud(studentID)

    def search(self, data):
        """
        Search a student by given data
        :param studentID: string, student data
        :return: student details if it exists, message otherwise
        """
        result = self.__studentRepo.searchStud(data)
        if result != "There is no student with given data.":
            for res in result:
                print(str(res))
        else:
            return result

    def searchStudID(self,ID):
        """
        Searches a student by given ID
        :param ID: integer, discipline's ID
        :return: name of the student
        """
        data = self.__studentRepo.searchStudByID(ID)
        if data != "There is no student with this ID.":
            for student in self.__studentRepo.get_student_repo():
                if student.get_studentID() == data:
                    return student.get_name()

    def update(self, studentID, name):
        """
        Updates the name of the student
        :param studendID: integer, studentID
        :param name:  string, new name
        """
        self.__studentRepo.update(studentID,name)

    def list(self):
        """
        :return: a string of the list of the students
        """
        return self.__studentRepo.list()