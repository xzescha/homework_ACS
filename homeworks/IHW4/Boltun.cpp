#include "Boltun.h"
#include <iostream>
#include <unistd.h>
#include <cstdlib>

extern int N;

Boltun::Boltun(int id, std::ostream& output) : id(id), output(output), isBusy(false) {}

void Boltun::run() {
    for (int i = 0; i < 30; ++i) {
        int action = rand() % 2;  // 0 - ждать, 1 - звонить

        if (action == 0) {
            wait();
        } else {
            call();
        }

        if (i == 29) {
            std::cout << "Boltun " << id << " says: 'I gotta go and study for my finals, getting out of the phone, bye!'" << std::endl;
            output << "Boltun " << id << " says: 'I gotta go and study for my finals, getting out of the phone, bye!'" << std::endl;
        }
    }
}

void Boltun::wait() {
    std::cout << "Boltun " << id << " is waiting for a call." << std::endl;
    output << "Boltun " << id << " is waiting for a call." << std::endl;
    usleep(rand() % 5000000 + 1000000);  // Ждем от 1 до 5 секунд
}

void Boltun::call() {
    int recipient = rand() % N + 1;
    while (recipient == id || boltuns[recipient - 1]->isBusy) {
        recipient = rand() % N + 1;
    }

    boltuns[recipient - 1]->isBusy = true;

    std::cout << "Boltun " << id << " is calling Boltun " << recipient << "." << std::endl;
    output << "Boltun " << id << " is calling Boltun " << recipient << "." << std::endl;

    usleep(rand() % 3000000 + 1000000);  // Звоним от 1 до 3 секунд

    std::cout << "Boltun " << recipient << " answered the call." << std::endl;
    output << "Boltun " << recipient << " answered the call." << std::endl;

    boltuns[recipient - 1]->isBusy = false;
}
