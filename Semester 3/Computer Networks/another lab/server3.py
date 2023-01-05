import socket
import pickle
def main():
    soc = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    soc.bind(("0.0.0.0",7777))
    soc.listen(5)
    cs,addr = soc.accept()
    name=cs.recv(20)
    print(pickle.loads(name))
    ip=addr[0]
    s=0
    print(ip)
    digits={'0':0,'1':1,'2':2,'3':3,'4':4,'5':5,'6':6,'7':7,'8':8,'9':9}
    for c in ip:
        if c in digits.keys():
            s+=digits[c]
    cs.send(pickle.dumps(s))
    cs.close()
main()