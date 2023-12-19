
#ifndef BOLTUN_H
#define BOLTUN_H

#include <iostream>
#include <vector>
#include <mutex>

class Boltun {
public:
    Boltun(int id, std::ostream& output, std::mutex& mutex);

    // Запуск потока болтуна
    void run();

private:
    int id;             // Идентификатор болтуна
    std::ostream& output;  // Поток вывода
    bool isBusy;        // Занят ли болтун разговором в данный момент
    std::mutex& mutex;  // Мьютекс для обеспечения потокобезопасности

    // Ждать звонка
    void wait();

    // Звонить другому болтуну
    void call();
};

// Объявление глобальной переменной N
extern int N;

// Объявление вектора указателей на болтуны
extern std::vector<Boltun*> boltuns;

#endif // BOLTUN_H
