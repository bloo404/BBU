from ui import Ui


def run():
    try:
        oui = Ui()
    except ValueError as ve:
        print(ve)
        return

    oui.run()


run()