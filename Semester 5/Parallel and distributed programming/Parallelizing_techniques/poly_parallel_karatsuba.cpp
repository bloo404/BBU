#include <iostream>
#include <vector>
#include <chrono>
#include <thread>
#include <mutex>

using namespace std;

mutex resultMutex;

vector<int> concatenate(vector<int> A, vector<int> B) {
    vector<int> result = move(A);
    result.insert(result.end(), B.begin(), B.end());
    return result;
}

vector<int> trimZeros(vector<int> poly) {
    int i = poly.size() - 1;
    while (i >= 0 && poly[i] == 0) {
        --i;
    }

    if (i < 0) {
        return {0};
    }

    return vector<int>(poly.begin(), poly.begin() + i + 1);
}

// Helper function for parallelizing the work
void karatsubaPartialMultiply(vector<int> A, vector<int> B, vector<int>& partialResult, int start, int end) {
    int n = A.size();

    for (int i = start; i < end; ++i) {
        for (int j = 0; j < n; ++j) {
            partialResult[i + j] += A[i] * B[j];
        }
    }
}

// Parallelized Karatsuba Multiply
vector<int> parallelKaratsubaMultiply(vector<int> A, vector<int> B, int numThreads) {
    int n = A.size();

    vector<int> result(n * 2 - 1, 0);

    if (n <= 4) {
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                result[i + j] += A[i] * B[j];
            }
        }
        return trimZeros(result);
    }

    int half = n / 2;
    vector<int> A0(A.begin(), A.begin() + half);
    vector<int> A1(A.begin() + half, A.end());
    vector<int> B0(B.begin(), B.begin() + half);
    vector<int> B1(B.begin() + half, B.end());

    vector<int> P1(n, 0), P2(n * 2 - 1, 0), P3(n, 0);

    // Create threads for partial multiplication
    vector<thread> threads;
    for (int i = 0; i < numThreads; ++i) {
        int start = i * half / numThreads;
        int end = (i + 1) * half / numThreads;
        threads.emplace_back(karatsubaPartialMultiply, move(A1), move(B1), ref(P1), start, end);
        threads.emplace_back(karatsubaPartialMultiply, move(A0), move(B0), ref(P3), start, end);
    }

    // Join the threads
    for (auto& t : threads) {
        t.join();
    }

    // Create threads for the cross multiplication
    threads.clear();
    for (int i = 0; i < numThreads; ++i) {
        int start = i * n / numThreads;
        int end = (i + 1) * n / numThreads;
        threads.emplace_back(karatsubaPartialMultiply, move(A1), move(B0), ref(P2), start, end);
        threads.emplace_back(karatsubaPartialMultiply, move(A0), move(B1), ref(P2), start, end);
    }

    // Join the threads
    for (auto& t : threads) {
        t.join();
    }

    // Synchronize access to the shared result vector using a mutex
    lock_guard<mutex> lock(resultMutex);

    // Combine the partial results
    for (int i = 0; i < n; ++i) {
        result[i] += P3[i];
        result[i + half] += P2[i] - P1[i] - P3[i];
        result[i + 2 * half] += P1[i];
    }

    return trimZeros(result);
}

int main() {
    auto start = chrono::high_resolution_clock::now();
    srand(time(NULL));

    vector<int> A, B;

    for (int i = 0; i < 10000; ++i) {
        A.push_back(i);
        B.push_back(1);
    }

    int maxDegree = max(A.size(), B.size());
    int newSize = 1;
    while (newSize < maxDegree) newSize *= 2;

    A.resize(newSize, 0);
    B.resize(newSize, 0);

    vector<int> result = parallelKaratsubaMultiply(move(A), move(B), 3);

    auto stop = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::microseconds>(stop - start) / 1000;
    cout << "Duration: " << duration.count() << " ms" << endl;

    return 0;
}
