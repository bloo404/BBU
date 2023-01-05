from random import randint

class wordRepository:
    def __init__(self,score):
        self._props = ["scramble","dream without fear","brevity is beautiful","The quick brown fox jumps over the lazy dog","work hard dream big"]
        self._score = score

    def get_score(self):
        """
        Returns score
        :return: int, score
        """
        return self._score

    def set_score(self,newScore):
        """
        Sets the score
        :param newScore: int, new score
        :return: nothing
        """
        self._score = newScore

    def shuffle(self,proposition):
        """
        Technically it scrambles the a word, kinda, practically my brain is giving more errors than the program
        :param proposition: string, word/proposition
        :return: string, scrambled proposition
        """
        #for i in range (1,len(proposition)-1):
         #   aux = proposition[i]
          #  proposition[i] = proposition[i+1]
           # proposition[i+1] = aux
        return proposition

    def get_proposition(self):
        """
        Gets a random proposition from the list of propositions
        :return: string, proposition/word
        """
        random = randint(1,4)
        prop = self._props[random]
        # prop = self.shuffle(prop)
        return prop

    def readTextFile(self):
        """
        Technically it reads from a textfile and puts those string values into the repo
        :return: nothing
        """
        f = open("input.txt", 'r')
        x = 0
        while x<2:
            #self._props[x] = f.readline()
            x = x + 1

    def isCorrect(self, proposition):
        """
        Verifies if the proposition is matching with the unscrambled word
        :param proposition:
        :return: 1 if it is solved, 0 if not
        """
        for prop in self._props:
            if proposition == prop:
                return 1
        return 0

    def validationCommands(self,tokens):
        pass

    def swapProposition(self,tokens,proposition):
        """
        Technically swaps letters between them, practically it has errors
        :param tokens: string, tokens from command
        :param proposition: string, proposition/word
        :return: nothing
        """
        numbers = tokens.split("-")
        aux = str(numbers[0])
        print(tokens)
        proposition[int(numbers[0])] = str(numbers[1])
        proposition[int(numbers[1])] = aux

    def swapOneWord(self,tokens,proposition,place1,place2):
        """
        Technically swaps letters in a word
        :param tokens: string, tokens from command
        :param proposition: string, a word
        :param place1: int, index1
        :param place2: int, index2
        :return: nothing
        """
        aux = proposition[place1]
        proposition[place1] = proposition[place2]
        proposition[place2] = aux


