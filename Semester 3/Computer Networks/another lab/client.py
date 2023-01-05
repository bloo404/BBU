import socket 
import pickle

def main():
    name = input()
    soc = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    soc.connect(("127.0.0.1",7777))
    soc.send(pickle.dumps(name))
    sum = soc.recv(10)
    print(pickle.loads(sum))
    soc.close()
main()