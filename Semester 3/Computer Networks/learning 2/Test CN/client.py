import socket
import pickle
import random
import time
import struct

# coordinatesX = [0,1,0,5,6]
# coordinatesY = [1,5,6,8,9]

n = 100

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

while(n):

	X = random.randint(-100,100)
	time.sleep(0.1)
	Y = random.randint(-100,100)	

	print("Client sending X,Y")

	# arrayXasBytes = pickle.dumps(coordinatesX)
	# XasBytes = pickle.dumps(X)
	XasBytes = struct.pack('i',X)

	# s.sendto(arrayXasBytes,(socket.gethostname(),8888))
	s.sendto(XasBytes,(socket.gethostname(),8888))

	print(str(n) + " sent X: (" + str(X) + ",")

	# arrayYasBytes = pickle.dumps(coordinatesY)
	# YasBytes = pickle.dumps(Y)
	YasBytes = struct.pack('i',Y)

	# s.sendto(arrayYasBytes,(socket.gethostname(),8888))
	s.sendto(YasBytes,(socket.gethostname(),8888))

	print(str(n) + " sent Y:" + str(Y) + ")")

	n = n-1
	# time.sleep(2)

msg, addr = s.recvfrom(100)

print("String received: ")
# print(pickle.loads(msg))

received = msg.decode('utf-8')
print(received)

def run():
	s2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s2.bind(("0.0.0.0",5555))

	while True:
		message2, addr2 = s2.recvfrom(200)
		print(message2.decode('utf-8'))
		if message2 == "End.":
			s2.close()

run()