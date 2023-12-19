#include "Boltun.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <mutex>
#include <omp.h>

int N;  // Определение переменной N
std::string inputFile = "config.txt";  // Имя файла ввода по умолчанию
std::string outputFile = "../output_data/output.txt";  // Имя файла вывода по умолчанию

std::vector<Boltun*> boltuns;  // Вектор для хранения указателей на объекты Boltun
std::mutex globalMutex;  // Общий мьютекс для всех болтунов

void exitFunction() {
    for (Boltun* boltun : boltuns) {
        delete boltun;
    }

    std::cout << "Exiting program..." << std::endl;
}

int main() {
    // Установка обработчика сигнала для корректного завершения программы по запросу пользователя
    std::atexit(exitFunction);

    int option;
    do {
        std::cout << "Choose the option for entering the value of N:" << std::endl;
        std::cout << "1. Enter from console" << std::endl;
        std::cout << "2. Enter from file" << std::endl;

        std::cout << "Enter your choice (1 or 2): ";
        std::cin >> option;
    } while (option != 1 && option != 2);

    if (option == 1) {
        do {
            std::cout << "Enter the number of Boltuns (N): ";
            std::cin >> N;
        } while (N <= 0);
    } else {
        do {
            std::cout << "Enter the name of the file containing N: ";
            std::cin >> inputFile;

            std::ifstream file(inputFile);
            if (!file.is_open()) {
                std::cout << "Error opening file. Please enter a valid file name." << std::endl;
            } else {
                file >> N;
                if (file.fail() || N <= 0) {
                    std::cout << "Invalid data in the file. Please make sure the file contains a valid positive integer for N." << std::endl;
                } else {
                    break;
                }
            }
        } while (true);
    }

    do {
        std::cout << "Enter the name of the output file: ";
        std::cin >> outputFile;

        std::ofstream testFile(outputFile);
        if (!testFile.is_open()) {
            std::cout << "Error creating file. Please enter a valid file name." << std::endl;
        } else {
            break;
        }
    } while (true);

    // Инициализация потоковых файлов
    std::ifstream configFile(inputFile);
    std::ofstream outputFileStream(outputFile);

#pragma omp parallel for
    for (int i = 0; i < N; ++i) {
        Boltun* boltun = new Boltun(i + 1, outputFileStream, globalMutex);
#pragma omp critical
        {
            boltuns.push_back(boltun);
        }
    }

#pragma omp parallel for
    for (int i = 0; i < N; ++i) {
        boltuns[i]->run();
    }

    return 0;
}
