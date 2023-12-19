#include "Boltun.h"
#include <iostream>
#include <fstream>
#include <pthread.h>
#include <string>
#include <vector>
#include <cstdlib>
#include <limits>

int N;  // Определение переменной N
pthread_t threads[100];  // Здесь предполагается, что не более 100 потоков будут создано
std::string configFile;  // Имя конфигурационного файла
std::string outputFile = "../output_data/output.txt";  // Имя файла вывода по умолчанию

std::vector<Boltun*> boltuns;  // Вектор для хранения указателей на объекты Boltun

void exitFunction() {
    for (Boltun* boltun : boltuns) {
        delete boltun;
    }

    std::cout << "Exiting program..." << std::endl;
}

void* boltunThread(void* arg) {
    Boltun* boltun = static_cast<Boltun*>(arg);
    boltun->run();
    return nullptr;
}

bool getIntFromCommandLine(int argc, char* argv[], int& value, const std::string& option) {
    for (int i = 1; i < argc; ++i) {
        if (argv[i] == option && i + 1 < argc) {
            value = std::atoi(argv[i + 1]);
            if (value > 0) {
                return true;
            } else {
                std::cout << "Invalid input. Please enter a valid positive integer for " << option << "." << std::endl;
                return false;
            }
        }
    }

    std::cout << "Missing or invalid command line argument: " << option << std::endl;
    return false;
}

bool getStringFromCommandLine(int argc, char* argv[], std::string& value, const std::string& option) {
    for (int i = 1; i < argc; ++i) {
        if (argv[i] == option && i + 1 < argc) {
            value = argv[i + 1];
            return true;
        }
    }

    std::cout << "Missing command line argument: " << option << std::endl;
    return false;
}

void readConfigFile(const std::string& fileName) {
    std::ifstream file(fileName);
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            if (line.find("Number of Boltuns:") != std::string::npos) {
                N = std::stoi(line.substr(line.find(":") + 1));
            } else if (line.find("Output file:") != std::string::npos) {
                outputFile = "../output_data/" + line.substr(line.find(":") + 1);
            }
        }
    } else {
        std::cout << "Error opening config file. Please make sure the file exists and is readable." << std::endl;
        exit(EXIT_FAILURE);
    }
}

bool getIntFromConsole(int& value) {
    std::cin >> value;

    if (std::cin.fail()) {
        std::cin.clear();
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n'); //очистка потока ввода при ошибочном вводе
        std::cout << "Invalid input. Please enter a valid integer." << std::endl;
        return false;
    }

    return true;
}

void enterNFromCommandLine(int argc, char* argv[]) {
    if (!getIntFromCommandLine(argc, argv, N, "-n")) {
        do {
            std::cout << "Enter the number of Boltuns (N): ";
        } while (!getIntFromConsole(N) || N <= 0);
    }
}

std::string enterOutputFileNameFromCommandLine(int argc, char* argv[]) {
    std::string fileName;

    if (!getStringFromCommandLine(argc, argv, fileName, "-o")) {
        do {
            std::cout << "Enter the name of the output file: ";
            std::cin >> fileName;

            std::ofstream testFile(fileName);
            if (!testFile.is_open()) {
                std::cout << "Error creating file. Please enter a valid file name." << std::endl;
            } else {
                return (fileName);
            }
        } while (true);
    }

    return fileName;
}

void enterConfigFileFromCommandLine(int argc, char* argv[]) {
    getStringFromCommandLine(argc, argv, configFile, "-c");
}

int main(int argc, char* argv[]) {
    // Установка обработчика сигнала для корректного завершения программы по запросу пользователя
    std::atexit(exitFunction);

    enterConfigFileFromCommandLine(argc, argv);
    if (!configFile.empty()) {
        configFile = "../configs/" + configFile;
        readConfigFile(configFile);
    } else {
        enterNFromCommandLine(argc, argv);
        outputFile = enterOutputFileNameFromCommandLine(argc, argv);
    }

    // Инициализация потоковых файлов
    std::ofstream outputFileStream(outputFile);

    for (int i = 0; i < N; ++i) {
        Boltun* boltun = new Boltun(i + 1, outputFileStream);
        boltuns.push_back(boltun);
        pthread_create(&threads[i], nullptr, boltunThread, static_cast<void*>(boltun));
    }

    for (int i = 0; i < N; ++i) {
        pthread_join(threads[i], nullptr);
        exitFunction();
    }

    return 0;
}       
