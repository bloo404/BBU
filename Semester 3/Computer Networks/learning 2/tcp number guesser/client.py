import socket 
import pickle


def run():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(("0.0.0.0",7777))
    guess = int(input())
    
    s.send(pickle.dumps(guess))
    buff = s.recv(50)
    answ = pickle.loads(buff)
    while answ == "Not yet": 
        guess = int(input())
        s.send(pickle.dumps(guess))
        buff = s.recv(50)
        answ = pickle.loads(buff)
    
run()