from wordRepository import wordRepository

class UI:
    def __init__(self):
        self.defeat = "F in the chat for you. Defeated by your own mind huh?"
        self.win = "You won! Your score is "

    def get_defeat(self):
        return self.defeat

    def get_win(self):
        return self.win