#include <thread>
#include <mutex>
#include <iostream>
#include <condition_variable>
#include <vector>

std::mutex mtx;
std::condition_variable cv;

bool state = false;
bool finished = false;

int p;
int sum = 0;

std::vector<int> a = {1, 2, 3, 4, 5};
std::vector<int> b = {1, 2, 3, 4, 5};

void produce() {
    for (int i = 0; i < 5; i++) {
        std::unique_lock<std::mutex> lk(mtx);
        p = a[i] * b[i];
        std::cout << i << "| Product:" << p << "\n";
        state = true;
        cv.notify_one();
        cv.wait(lk, [] { return !state || finished; });
        lk.unlock();
    }
    std::unique_lock<std::mutex> lk(mtx);
    finished = true;
    cv.notify_one();
}

void consume() {
    for (int i = 0; i < 5; i++) {
        std::unique_lock<std::mutex> lk(mtx);
        cv.wait(lk, [] { return state || finished; });
        if (state) {
            sum += p;
            std::cout << i << "| Sum:" << sum << "\n";
            state = false;
            cv.notify_one();
        }
        if (finished)
            break;
    }
}

int main() {
    std::thread producer(produce);
    std::thread consumer(consume);
    producer.join();
    consumer.join();
    std::cout << "Sum is: " << sum << '\n';
    return 0;
}
