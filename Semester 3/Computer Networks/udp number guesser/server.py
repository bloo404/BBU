#Guess the number game using UDP

import socket
import pickle
num = 100
fdback="Not yet"
victory="Win"
def run():
    s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    s.bind(("0.0.0.0",7777))

    while True:
        print("Waiting for number")
        buffer,addr = s.recvfrom(10)
        guess = pickle.loads(buffer) 
        if guess == num: 
            print("You won!")
            s.sendto(pickle.dumps(victory),addr)
            break
        elif guess>num:
            print("Try a smaller number")
        else: 
            print ("Try a bigger number")
        s.sendto(pickle.dumps(fdback),addr)

run()