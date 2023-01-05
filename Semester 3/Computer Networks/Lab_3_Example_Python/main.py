__author__ = "bloo_404"

import socket
import struct

server_nr = 10


def handle_client(client_socket):
    while True:
        n = client_socket.recv(4)
        n = struct.unpack('!I', n)[0]
        print("The client sent the number.",n,'\n' )
        if n == server_nr:
            client_socket.send(b"You won!") # this is a byte array
        elif n < server_nr:
            client_socket.send(b"Higher")
        else:
            client_socket.send(b"Lower")


if __name__=='__main__':
    rs = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    rs.bind(('0.0.0.0',1234))
    rs.listen(10)
    print("Listening for connection")

    while True:
        client_socket, addrc = rs.accept()
        print("Acception connection", addrc)
        handle_client(client_socket)
