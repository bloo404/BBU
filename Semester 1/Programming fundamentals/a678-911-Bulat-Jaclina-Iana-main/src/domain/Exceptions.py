class StudentException(Exception):
    """
        Custom written exceptions
    """
    def __init__(self,message):
        """
        Initializing the class
        :param message: string, error message
        """
        self.__message = message

    def __str__(self):
        """
        Return the error message
        :return: string, error message
        """
        return self.__message

class DisciplineException(Exception):
    """
        Custom written exceptions
    """
    def __init__(self,message):
        """
        Initializing the class
        :param message: string, error message
        """
        self.__message = message

    def __str__(self):
        """
        Return the error message
        :return: string, error message
        """
        return self.__message

class GradeException(Exception):
    """
        Custom written exceptions
    """

    def __init__(self, message):
        """
        Initializing the class
        :param message: string, error message
        """
        self.__message = message

    def __str__(self):
        """
        Return the error message
        :return: string, error message
        """
        return self.__message