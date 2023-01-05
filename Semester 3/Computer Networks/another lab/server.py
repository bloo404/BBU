import socket
import pickle
def main():
    soc = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    soc.bind(("0.0.0.0",7777))
    soc.listen(5)
    cs,addr = soc.accept()
    name=cs.recv(20)
    print(pickle.loads(name))
    port=addr[1]
    s=0
    print(port)
    while port:
        s+=port%10
        port=port//10
    cs.send(pickle.dumps(s))
    cs.close()
main()