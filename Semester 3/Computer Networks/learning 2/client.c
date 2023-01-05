// #include <sys/types.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
// #include <Winsock.h>
#include <stdio.h>
// #include <arpa/inet.h>
// #include <netinet/in.h>

///  gcc -Wall -o nume nume.c -lws2_32

/* Transfer C Protocol

/// send pe bytes & reliable
/// send + recv

/// UDP pe packete de bytes & unreliable
/// send to, receive from

/// asta e tcp */

int main(){
	int PORT = 1234;
	char ADDRESS[256] = "192.168.43.34";

	int sock_fd = socket(AF_INET,SOCK_DGRAM,0); /// dgram = diagram, adress family internet
	/// -1 if not done
	if(sock_fd == -1){
		perror("Socket failed!\n"); /// \n is essential
		return -1;
	}

	struct sockaddr_in client_addr; /// family, port, addresa
	client_addr.sin_family = AF_INET; /// familia <- adresa de famlilie de mai sus
	client_addr.sin_port = htons(PORT); /// port <- short pt ip mic, long pt ip mare
	inet_pton(AF_INET, ADDRESS, &client_addr.sin_addr);

	socklen_t len = sizeof(client_addr); /// kinda int

	int rez = connect(sock_fd,(struct sockaddr*) & client_addr, len); /// client -> conect, server bind

	if(rez == -1){
		perror("Connection failed!\n");
		return -1;
	}



	return 0;
}