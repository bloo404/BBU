import socket
import pickle
import struct
import random

n = 100
coordinatesX = [0] * 101
coordinatesY = [0] * 101 # just to be sure 100% we have space
index = 0

s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind(("0.0.0.0",8888))

while(n):
		
	# x coord
	buff, addr = s.recvfrom(201)

	# xCords = pickle.loads(buff)
	# x = pickle.loads(buff)
	x = struct.unpack('i',buff)

	print(str(n) + " received X:" + str(x))

	# y coordinates
	buff2, addr2 = s.recvfrom(201) 

	# yCords = pickle.loads(buff)
	# y = pickle.loads(buff2)
	y = struct.unpack('i',buff2)

	print(str(n) + " received Y: " + str(y))

	coordinatesX[index] = x
	coordinatesY[index] = y

	n = n - 1
	index = index + 1


print("All coordinates received")

message = "We received the coordinates from you."

# messageBytes = bytes(message, 'utf-8')    # Or other appropriate encoding
# struct.pack("I%ds" % (len(messageBytes),), len(messageBytes), messageBytes)

messageBytes = message.encode('utf-8')
s.sendto(messageBytes,addr)

# s.sendto(pickle.dumps(message),addr)

def udp():
	s2 = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

	n = random.randint(0,200)

	while (n):
		if n!=1:
			print("Sending a string.")
			msg2 = "The world is changing all the time.\n But sometimes it doesn't at all."
			messageBytes2 = msg2.encode('utf-8')
			s2.sendto(messageBytes2,(socket.gethostname(),5555))
		else:
			msg2 = "End."
			messageBytes2 = msg2.encode('utf-8')
			s2.sendto(messageBytes2,(socket.gethostname(),5555))
		n = n-1

udp()