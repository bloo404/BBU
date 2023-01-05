import socket
import pickle

def sum(array):
    s=0
    for n in array:
        s+=n 
    return s


s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

s.bind(("0.0.0.0",5555))
buff,addr = s.recvfrom(50)

info = pickle.loads(buff)

result = sum(info)

print("Array received, sending back sum.")

s.sendto(pickle.dumps(result),addr)