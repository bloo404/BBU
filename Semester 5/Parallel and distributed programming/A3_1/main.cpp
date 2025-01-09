#include <iostream>
#include <thread>
#include <mutex>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <chrono>

using namespace std::chrono;

std::mutex result_mutex;
int mat_size = 100;

void compute_matrix_element(int result[100][100], int a[100][100], int b[100][100], int row, int col, int task_id) {
    int sum = 0;

    for (int i = 0; i < mat_size; ++i) {
        sum += a[row][i] * b[i][col];
    }
    std::lock_guard<std::mutex> lock(result_mutex);
    std::cout << "Thread " << task_id << " on position (" << row << " , " << col
              << ") => " << sum << std::endl;
    result[row][col] = sum;
}

void parallel_task(int result[100][100], int a[100][100], int b[100][100], int task_id, int task_size) {
    int i = 0;
    int j = task_id;

    while (i < mat_size) {
        while (j < mat_size) {
            compute_matrix_element(result, a, b, i, j, task_id);
            j += task_size;
        }
        i += 1;
        j = j % mat_size;
    }
}

int main() {
    auto start = high_resolution_clock::now();

    srand(time(NULL));

    int a[100][100];
    int b[100][100];
    int result[100][100];

    for (int i = 0; i < mat_size; ++i) {
        for (int j = 0; j < mat_size; ++j) {
            a[i][j] = rand() % 5;
            b[i][j] = rand() % 5;
        }
    }

    std::cout << "------ MATRIX A -------\n";
    for (int i = 0; i < mat_size; ++i) {
        for (int j = 0; j < mat_size; ++j) {
            std::cout << a[i][j] << " ";
        }
        std::cout << std::endl;
    }
    std::cout << "-----------------------\n";

    std::cout << "------ MATRIX B -------\n";
    for (int i = 0; i < mat_size; ++i) {
        for (int j = 0; j < mat_size; ++j) {
            std::cout << b[i][j] << " ";
        }
        std::cout << std::endl;
    }
    std::cout << "-----------------------\n";

    std::vector<std::thread> threads;
    int num_threads = 4;

    for (int task_id = 0; task_id < num_threads; task_id++) {
        threads.emplace_back([&, task_id]() {
            parallel_task(result, a, b, task_id, num_threads);
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }

    for (int i = 0; i < mat_size; ++i) {
        for (int j = 0; j < mat_size; ++j) {
            std::cout << result[i][j] << ' ';
        }
        std::cout << std::endl;
    }

    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start)/1000;
    std::cout << "Duration: " << duration.count() << " ms" << std::endl;
    return 0;
}
