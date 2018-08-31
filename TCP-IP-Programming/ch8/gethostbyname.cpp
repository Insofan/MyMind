//
// Created by Insomnia on 2018/8/31.
//

//bug

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <iostream>

using namespace std;

void errorHanding(char *message);

int main(int argc, char *argv[]) {
    struct hostent *host;

    if (argc != 2) {
        cout << "Usage : " << argv[0] << endl;
        exit(1);
    }

    host = gethostbyname(argv[1]);

    if (!host) {
        errorHanding("gethost err");
    }

    cout << "Official name " << host->h_name << endl;

    for (int i = 0; i < host->h_aliases; i++) {
        printf("Aliases %d: %s \n", i + 1, host->h_aliases[i]);
    }

    cout << " Address type: " << (host->h_addrtype == AF_INET) ? "AF_INET" : "AF_INET6" << endl;


    return 0;
}


void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}
