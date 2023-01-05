from ui import UI
from wordRepository import wordRepository

class Controller:
    ui = UI
    Repo = wordRepository(0)
    Repo.set_score(16)
    score = 16
    Repo.readTextFile()
    chosenProposition = Repo.get_proposition() + " "
    try:
        while Repo.get_score() > 0 and Repo.isCorrect(chosenProposition) == 0:
            print("You must continue.")
            print(chosenProposition," [", "score is: ",Repo.get_score(),"]")
            print("Which letters are you swapping?")

           # validity = 0
           # while validity==0:
            command = input(">")
            tokens = command.split(" ")
            #    numbers = tokens[1].split("-")
             #   if len(tokens) < 3:
              #      if tokens[0]!="swap":
               #         print("Give a vaild input.")
                #    elif numbers[0] != int() or numbers[1] != int():
                 #       print("Give a valid input.")
                #else:
                 #   validity = 1

            if len(tokens) > 2:
                #Repo.swapProposition(tokens, chosenProposition)
                Repo.set_score(Repo.get_score() - 1)
            else:
                #Repo.swapOneWord(tokens, chosenProposition,1,2)
                Repo.set_score(Repo.get_score() - 1)

        if Repo.get_score() == 0:
            print("F in the chat for you. Defeated by your own mind huh?")
        if Repo.isCorrect == 1:
            print("You won! Your score is ", Repo.get_score())

    except:
        print("Something went wrong, I can feel it.")


controller = Controller


