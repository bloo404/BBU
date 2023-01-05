#Guess the number game using UDP

import socket
import pickle
num = 100
fdback="Not yet"
victory="Win"


def run():
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.bind(("0.0.0.0",7777))
    s.listen(5)
    cs,addr = s.accept()
    while True:
        print("Waiting for number")
        buffer = cs.recv(10)
        guess = pickle.loads(buffer) 
        if guess == num: 
            print("You won!")
            cs.send(pickle.dumps(victory))
            break
        elif guess>num:
            print("Try a smaller number")
        else: 
            print ("Try a bigger number")
        cs.send(pickle.dumps(fdback))
    #cs.close()
run()