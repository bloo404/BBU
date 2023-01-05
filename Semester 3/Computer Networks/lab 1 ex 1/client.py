import socket
import pickle

array = [1,2,3,4]

s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

print("Client sending the array to the server.")
arrayAsBytes = pickle.dumps(array)

s.sendto(arrayAsBytes,("127.0.0.1",5555))

msg, addr = s.recvfrom(10)

print("Sum received: ")
print(pickle.loads(msg))