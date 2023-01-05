__author__ = "bloo_404"

import socket
import struct
import random

def client():
    my_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    my_socket.connect(('localhost', 1234))

    o_rand_number = random.randint(0, 100)

    rand_number = struct.pack('!I',o_rand_number)
    my_socket.send(rand_number)

    left = 0
    right = 100

    while True:

        recv_string = my_socket.recv(32)

        if recv_string == b"You won!":
            print("I won!")
            break
        elif recv_string == b"Lower":
            right = o_rand_number - 1
            o_rand_number = (right + left) // 2
            print("Generated a new number: ", o_rand_number)
            my_socket.send(struct.pack('!I', o_rand_number))
        else:
            left = o_rand_number + 1
            o_rand_number = (right + left) // 2
            print("Generated a new number: ", o_rand_number)
            my_socket.send(struct.pack('!I', o_rand_number))

client()